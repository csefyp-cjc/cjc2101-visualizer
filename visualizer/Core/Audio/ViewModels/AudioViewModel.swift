//
//  AudioViewModel.swift
//  visualizer
//
//  Created by Mark Cheng on 19/11/2021.
//
// ref: https://github.com/Matt54/AudioVisualizerAK5

import Foundation
import Combine
import AudioKit
import SoundpipeAudioKit

enum UpdateMode{
    case scroll
    case average
}

class AudioViewModel: ObservableObject{
    @Published var audio: Audio = Audio.default
    @Published var referenceHarmonicAmplitudes: [Double] = Array(repeating: 0.5, count: 10)
    
    // Subscribed from child ViewModels
    @Published var settings: Setting = Setting.default
    
    @Published var timbreDrawer: TimbreDrawer = TimbreDrawer.default
        
    // Child ViewModels
    private var cancellables = Set<AnyCancellable>()
    @Published var settingVM = SettingViewModel()
    
    @Published var timbreDrawerVM = TimbreDrawerViewModel()
        
        
    // AudioKit
    private var isStarted: Bool = false
    private let engine = AudioEngine()
    private var mic: AudioEngine.InputNode
    private let fftMixer: Mixer
    private let pitchMixer: Mixer
    private let silentMixer: Mixer
    private var taps: [BaseTap] = []
    private let FFT_SIZE = 2048
    private let sampleRate: double_t = 44100
    private let outputLimiter: PeakLimiter
    
    
    init(){
        // TODO: test no microphone priviledge
        guard let input = engine.input else{
            fatalError()
        }
        
        self.mic = input
        self.fftMixer = Mixer(mic)
        self.pitchMixer = Mixer(fftMixer)
        self.silentMixer = Mixer(pitchMixer)
        self.outputLimiter = PeakLimiter(silentMixer)
        self.engine.output = outputLimiter
        
        self.setupAudioEngine()
        self.addSubscribers()
        
        self.updateReferenceTimbre()
    }
    
    private func setupAudioEngine() {
        taps.append(FFTTap(fftMixer){ fftData in
            DispatchQueue.main.async{
                self.updateAmplitudes(fftData, mode: .scroll)
            }
        })
        taps.append(PitchTap(pitchMixer){ pitchFrequency, amplitude in
            DispatchQueue.main.async{
                self.updatePitch(pitchFrequency: pitchFrequency, amplitude: amplitude)
            }
        })
        
        self.toggle()
        silentMixer.volume = 0.0
    }
    
    // Add subscriptions from child ViewModels
    private func addSubscribers() {
        settingVM.$settings.sink { [weak self] (returnedSettings) in
            self?.settings = returnedSettings
        }
        .store(in: &cancellables)
        
        timbreDrawerVM.$timbreDrawer.sink { [weak self] (returnedTimbreDrawer) in
            self?.timbreDrawer = returnedTimbreDrawer
        }
        .store(in: &cancellables)
    }
    
    // Audio Engine functions
    func start(){
        do{
            try engine.start()
            taps.forEach{ tap in
                tap.start()
            }
        }catch{
            assert(false, error.localizedDescription)
        }
        self.isStarted = true
    }
    
    func stop(){
        engine.stop()
        taps.forEach{ tap in
            tap.stop()
        }
        self.isStarted = false
    }
    
    func toggle() {
        if(self.isStarted){
            self.stop()
        }else{
            self.start()
        }
    }
    
    func getPitchIndicatorPosition() -> Int {
        switch audio.pitchDetune {
        case let cent where cent < 0:
            return 4 - Int(abs(audio.pitchDetune) / 12.5)
        case let cent where cent > 0:
            return Int(audio.pitchDetune / 12.5) + 4
        case let cent where cent == 0:
            return 4
        default:
            return 4
        }
    }
    
    private func updateIsPitchAccurate() {
        let position = getPitchIndicatorPosition()
        var accuracyPoint: [Int] {
            switch self.settings.accuracyLevel {
            case .tuning:
                return [4]
            case .practice:
                return [3, 4, 5]
            }
        }
                
        audio.isPitchAccurate = accuracyPoint.contains(position)
    }
    
    // PitchTap functions
    private func updatePitch( pitchFrequency: [Float], amplitude: [Float]) {
        var noiseThreshold: Float = 0.05
        
        switch self.settings.noiseLevel {
        case .low:
            noiseThreshold = 0.05
        case .medium:
            noiseThreshold = 0.1
        case .high:
            noiseThreshold = 0.5
        }
        
        // TODO: May consider for headphone input (L/R channel)
        if (amplitude[0] > noiseThreshold) {
            self.audio.pitchFrequency = pitchFrequency[0]
            self.audio.pitchNotation = pitchFromFrequency(pitchFrequency[0], self.settings.noteRepresentation)
            self.audio.pitchDetune = pitchDetuneFromFrequency(pitchFrequency[0])
            self.audio.peakBarIndex = Int(pitchFrequency[0] * Float(self.FFT_SIZE) / Float(self.sampleRate))
//            print("🔖 Pitch Detune (Cent)   \(audio.pitchDetune)")
            
            // TODO: maybe only compute these values when current view is timbre view
            // update harmonicAmplitudes
            let hamonics = getHarmonics(fundamental: pitchFrequency[0], n: 10) //TODO: adjustable n
            for (index, harmonic) in hamonics.enumerated() {
                let harmonicIndex = Int(harmonic*2048/44100)
                if(harmonicIndex > 255){
                    self.audio.harmonicAmplitudes[index] = 0
                }else{
                    self.audio.harmonicAmplitudes[index] = self.audio.amplitudes[Int(harmonic*2048/44100)]
                }
            }
            
        }
        self.updateReferenceTimbre()
        self.updateIsPitchAccurate()
    }
    
    // FTTTap functions
    private func updateAmplitudes(_ fftData: [Float], mode: UpdateMode){
        let binSize = 30
        var bin = Array(repeating: 0.0, count: self.audio.amplitudes.count) // stores amplitude sum
        var noiseThreshold: Double = 0.05
        
        switch self.settings.noiseLevel {
        case .low:
            noiseThreshold = 0.05
        case .medium:
            noiseThreshold = 0.1
        case .high:
            noiseThreshold = 0.5
        }
        
        for i in stride(from : 0, to: self.FFT_SIZE - 1, by: 2){
            let real = fftData[i]
            let imaginary = fftData[i+1]
            
            let normalizedMagnitude = 2.0 * sqrt(pow(real, 2) + pow(imaginary, 2)) / Float(self.FFT_SIZE)
            let amplitude = Double(20.0 * log10(normalizedMagnitude))
            let scaledAmplitude = (amplitude + 250) / 229.80
            
            if(mode == .average){
                // simple explaination
                // bin[0] = sum(fftData[0:n-1])/n
                if(i/binSize < self.audio.amplitudes.count){
                    bin[i/binSize] = bin[i/binSize] + restrict(value: scaledAmplitude)
                }
                
                DispatchQueue.main.async {
                    if(i%binSize == 0 && i/binSize < self.audio.amplitudes.count){
                        self.audio.amplitudes[i/binSize] = bin[i/binSize] / Double(binSize)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    if(i/2 < self.audio.amplitudes.count){
                        var mappedAmplitude = self.map(n: scaledAmplitude, start1: 0.3, stop1: 0.9, start2: 0.0, stop2: 1.0)
                        if(mappedAmplitude < noiseThreshold){
                            mappedAmplitude = 0
                        }
                        self.audio.amplitudes[i/2] = self.restrict(value: mappedAmplitude)
                    }
                }
            }
        }
    }
    
    func updateReferenceTimbre() {
        var scaledCelloA2: [Double]
        
        switch self.timbreDrawer.selected {
        case .cello:
            scaledCelloA2 = cello[pitchFromFrequency(self.audio.pitchFrequency, Setting.NoteRepresentation.sharp)] ?? []
        case .flute:
            scaledCelloA2 = flute[pitchFromFrequency(self.audio.pitchFrequency, Setting.NoteRepresentation.sharp)] ?? []
        default:
            scaledCelloA2 = cello[pitchFromFrequency(self.audio.pitchFrequency, Setting.NoteRepresentation.sharp)] ?? []
        }
                
        if (!scaledCelloA2.isEmpty) {
            for (i, amplitude) in scaledCelloA2.enumerated() {
                scaledCelloA2[i] = amplitude/10e1
                scaledCelloA2[i] = Double(20.0 * log10(scaledCelloA2[i]))
                scaledCelloA2[i] = (scaledCelloA2[i] + 50) / 29.80
            }

            let hamonics = getHarmonics(fundamental: mapNearestFrequency(self.audio.pitchFrequency), n: 10) //TODO: adjustable n
            for (index, harmonic) in hamonics.enumerated() {
                let harmonicIndex = Int(harmonic*2048/44100)
                if(harmonicIndex > 255){
                    self.referenceHarmonicAmplitudes[index] = 0
                }else{
                    self.referenceHarmonicAmplitudes[index] = scaledCelloA2[Int(harmonic*2048/44100)]

                }
            }
        }
    }
    
    // TODO: modify this mapping for our visualization
    private func map(n: Double, start1: Double, stop1: Double, start2: Double, stop2: Double) -> Double {
        return ((n-start1)/(stop1-start1)) * (stop2-start2) + start2
    }
    
    private func restrict(value: Double) -> Double {
        if(value < 0.0) {
            return 0
        }
        if(value > 1.0){
            return 1.0
        }
        return value
    }
    
    private func getHarmonics(fundamental: Float, n: Int) -> [Float]{
        var harmonics:[Float] = Array(repeating: 0.0, count:n)
        for i in (0...n-1){
            harmonics[i] = fundamental * Float(i)
        }
        return harmonics
    }
    

}
