import Foundation
import AVFoundation
import Accelerate

//TODO: seperate background thread and audioContext
//TODO: make an audioContext to receive background thread processed data
final public class AudioModel: NSObject, AVCaptureAudioDataOutputSampleBufferDelegate, ObservableObject {

    var started = false

    // Samples per frame — the height of the spectrogram.
    static let sampleCount = 1024

    // Number of displayed buffers — the width of the spectrogram.
    static let bufferCount = 768

    // Determines the overlap between frames.
    static let hopCount = 512

    // Perform real-time capturing
    // flow the data from AVCaptureDeviceInput to AVCaptureAudioDataOoutput
    let captureSession = AVCaptureSession()

    // calls captureOutput in SampleBufferDelegate when receving samples
    let audioOutput = AVCaptureAudioDataOutput()

    // An Int16 Array containing audio samples that may have count > sampleCount
    var rawAudioData = [Int16]()

    // a queue task for audio output's sample buffer delegate (captureOutput)
    let captureQueue = DispatchQueue(label: "captureQueue",
                                     qos: .userInitiated, // quality of service, priority of this task
                                     attributes: [],
                                     autoreleaseFrequency: .workItem)

    // a queue task to run capture session asynchronously
    let sessionQueue = DispatchQueue(label: "sessionQueue",
                                     attributes: [],
                                     autoreleaseFrequency: .workItem)

    let forwardDCT = vDSP.DCT(count: sampleCount,
                              transformType: .II)!

    // The window sequence used to reduce spectral leakage.
    let hanningWindow = vDSP.window(ofType: Float.self,
                                    usingSequence: .hanningDenormalized,
                                    count: sampleCount,
                                    isHalfWindow: false)

    // Raw frequency domain values.
    var frequencyDomainValues = [Float](repeating: 0,
                                        count: bufferCount * sampleCount)

    // A reusable array that contains the current frame of time domain audio data as single-precision
    // values.
    var timeDomainBuffer = [Float](repeating: 0,
                                   count: sampleCount)

    // A resuable array that contains the frequency domain representation of the current frame of
    // audio data.
    var frequencyDomainBuffer = [Float](repeating: 0, count: sampleCount)
    
    // for locking resources in multi-threading
    let dispatchSemaphore = DispatchSemaphore(value: 1)
    
    @Published var amplitudes = [CGFloat](repeating: 0.5, count: 64)

    override init(){
        super.init()

        configureCaptureSession()

        audioOutput.setSampleBufferDelegate(self, queue: captureQueue)
    }

    func processData(values: [Int16]){
        dispatchSemaphore.wait()

        // Converts 16-bit unsigned integers to double-precision values.
        vDSP.convertElements(of: values, to: &timeDomainBuffer)

        // muliply by window to reduce spectral leakage
        vDSP.multiply(timeDomainBuffer,
                      hanningWindow,
                      result: &timeDomainBuffer)

        // transform time domain to freq doamin
        // return complex value
        forwardDCT.transform(timeDomainBuffer,
                             result: &frequencyDomainBuffer)

        // magnitude value = abs(complex value)
        vDSP.absolute(frequencyDomainBuffer,
                      result: &frequencyDomainBuffer)

        // convert amplitude to dB (loudness)
        vDSP.convert(amplitude: frequencyDomainBuffer,
                     toDecibels: &frequencyDomainBuffer,
                     zeroReference: Float(AudioModel.sampleCount))

        // remove head values , append new values
        if frequencyDomainValues.count > AudioModel.sampleCount {
            frequencyDomainValues.removeFirst(AudioModel.sampleCount)
        }

        frequencyDomainValues.append(contentsOf: frequencyDomainBuffer)
        
        // unlock resource
        dispatchSemaphore.signal()

    }

    // AVCaptureAudioDataOutput calls this function whenever it receives audio sample buffer ~~ a list of samples
    // CMSampleBuffer: Core Foundation Media Sample Buffer
    // Core Foundation: Framework to access low level funcitons
    public func captureOutput(_ output: AVCaptureOutput,didOutput sampleBuffer: CMSampleBuffer,from connection: AVCaptureConnection) {
        var audioBufferList = AudioBufferList()
        var blockBuffer: CMBlockBuffer?

        // From CMSamepleBuffer get AudioBufferList
        CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(
            sampleBuffer,
            bufferListSizeNeededOut: nil,
            bufferListOut: &audioBufferList,
            bufferListSize: MemoryLayout.stride(ofValue: audioBufferList),
            blockBufferAllocator: nil,
            blockBufferMemoryAllocator: nil,
            flags: kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment,
            blockBufferOut: &blockBuffer)

        // pointer to raw audio data
        guard let data = audioBufferList.mBuffers.mData else {
            return
        }

        // create an Array from data and append to rawAudioData
        if self.rawAudioData.count < (AudioModel.sampleCount + AudioModel.hopCount * 2) {
            // actual sample count can be more than 1024 (AudioModel.sampleCount)
            let actualSampleCount = CMSampleBufferGetNumSamples(sampleBuffer)

            // bind first <actualSampleCount> bytes to Int16 type
            let ptr = data.bindMemory(to: Int16.self, capacity: actualSampleCount)
            let buf = UnsafeBufferPointer(start: ptr, count: actualSampleCount)

            // append Int16 array to rawAudioData
            rawAudioData.append(contentsOf: Array(buf))
        }

        // when this sample has at least sampleCount, we process the data
        while self.rawAudioData.count >= AudioModel.sampleCount {
            // only process first sampleCount data
            let dataToProcess = Array(self.rawAudioData[0 ..< AudioModel.sampleCount])
            self.rawAudioData.removeFirst(AudioModel.hopCount)
            self.processData(values: dataToProcess)
        }

        // self.renderUI()
    }

    func configureCaptureSession() {
        // "Privacy - Microphone Usage Description" entry required in pinfo.
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
            case .authorized:
                    break
            case .notDetermined:
                sessionQueue.suspend()
                AVCaptureDevice.requestAccess(for: .audio,
                                              completionHandler: { granted in
                    if !granted {
                        fatalError("App requires microphone access.")
                    } else {
                        self.configureCaptureSession()
                        self.sessionQueue.resume()
                    }
                })
                return
            default:
                // Users can add authorization in "Settings > Privacy > Microphone"
                // on an iOS device, or "System Preferences > Security & Privacy >
                // Microphone" on a macOS device.
                fatalError("App requires microphone access.")
        }

        captureSession.beginConfiguration()

        #if os(macOS)
        // Note than in macOS, you can change the sample rate, for example to
        // `AVSampleRateKey: 22050`. This reduces the Nyquist frequency and
        // increases the resolution at lower frequencies.
        audioOutput.audioSettings = [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMBitDepthKey: 16,
            AVNumberOfChannelsKey: 1]
        #endif

        if captureSession.canAddOutput(audioOutput) {
            captureSession.addOutput(audioOutput)
        } else {
            fatalError("Can't add `audioOutput`.")
        }

        guard
            let microphone = AVCaptureDevice.default(.builtInMicrophone,
                                                     for: .audio,
                                                     position: .unspecified),
            let microphoneInput = try? AVCaptureDeviceInput(device: microphone) else {
                fatalError("Can't create microphone.")
            }

        if captureSession.canAddInput(microphoneInput) {
            captureSession.addInput(microphoneInput)
        }

        captureSession.commitConfiguration()
    }
    
    func start() {
        started = !started
        sessionQueue.async {
            if AVCaptureDevice.authorizationStatus(for: .audio) == .authorized {
                self.captureSession.startRunning()
            }
        }
    }

}
