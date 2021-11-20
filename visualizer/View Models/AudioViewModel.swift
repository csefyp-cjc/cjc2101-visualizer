//
//  AudioViewModel.swift
//  visualizer
//
//  Created by Mark Cheng on 19/11/2021.
//
// ref: https://github.com/Matt54/AudioVisualizerAK5
import Foundation
import AudioKit

enum UpdateMode{
    case limited
    case average
}

class AudioViewModel: ObservableObject{
    
    let engine = AudioEngine()
    
    var mic: AudioEngine.InputNode
    
    let micMixer: Mixer
    
    let silentMixer: Mixer
    
    var fft: FFTTap!
    
    let FFT_SIZE = 2048
    
    let sampleRate: double_t = 44100
    
    let outputLimiter: PeakLimiter
    
    // TODO: May change this with array model when our audio model not only containing amplitude arrayM
    @Published var amplitudes: [Double] = Array(repeating: 0.5, count: 50)
    @Published var peakFrequency: Double = -1.0
    
    
    init(){
        // TODO: test no microphone priviledge
        guard let input = engine.input else{
            fatalError()
        }
        
        mic = input
        micMixer = Mixer(mic)
        silentMixer = Mixer(micMixer)
        
        outputLimiter = PeakLimiter(silentMixer)
        
        engine.output = outputLimiter
        
        fft = FFTTap(micMixer){fftData in
            DispatchQueue.main.async {
                self.updateAmplitudes(fftData, mode: .average)
            }
        }
        
        do{
            try engine.start()
            fft.start()
        }catch{
            assert(false, error.localizedDescription)
        }
        
        silentMixer.volume = 0.0
        
    }
    
    func updateAmplitudes(_ fftData: [Float], mode: UpdateMode){
        let binSize = 30
        var bin = Array(repeating: 0.0, count: self.amplitudes.count) // stores amplitude sum
        var maxAmplitude = 0.0, maxIndex = -1
        
        for i in stride(from : 0, to: self.FFT_SIZE - 1, by: 2){
            let real = fftData[i]
            let imaginary = fftData[i+1]
            
            let normalizedBinMagnitude = 2.0 * sqrt(pow(real, 2) + pow(imaginary, 2)) / Float(self.FFT_SIZE)
            let amplitude = Double(20.0 * log10(normalizedBinMagnitude))
            
            let scaledAmplitude = (amplitude + 250) / 229.80
            
            if(!scaledAmplitude.isLess(than: maxAmplitude)){
                maxAmplitude = scaledAmplitude
                maxIndex = i / 2
            }
            
            if(mode == .average){
                if(i/binSize < self.amplitudes.count){
                    bin[i/binSize] = bin[i/binSize] + restrict(value: scaledAmplitude)
                }
            }
            
            
            DispatchQueue.main.async{
                if(mode == .average){
                    if(i%binSize == 0 && i/binSize < self.amplitudes.count){
                        self.amplitudes[i/binSize] = bin[i/binSize] / Double(binSize)
                    }
                }else{
                    if(i/2 < self.amplitudes.count){
                        self.amplitudes[i/2] = self.map(n: scaledAmplitude, start1: 0.3, stop1: 0.9, start2: 0.0, stop2: 1.0)
                    }
                }
            }
        }
        //TODO: not accurate enough, error ~= 2 in result
        // For A4 = 440Hz
        // e.g. 440Hz should have maxIndex = 20.43356
        // e.g. 27.5Hz should have maxIndex = 1.27709
        self.peakFrequency = Double(maxIndex * Int(self.sampleRate) / self.FFT_SIZE) + 10.0
        print("\(self.peakFrequency) Hz")
    }
    
    
    // TODO: modify this mapping for our visualization
    func map(n: Double, start1: Double, stop1: Double, start2: Double, stop2: Double) -> Double {
        return restrict(value: ((n-start1)/(stop1-start1)) * (stop2-start2) + start2)
    }
    
    func restrict(value: Double) -> Double {
        if(value < 0) {
            return 0
        }
        if(value > 1.0){
            return 1.0
        }
        return value
    }
}
