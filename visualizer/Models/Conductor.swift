//
//  Conductor.swift
//  visualizer
//
//  Created by Mark Cheng on 19/11/2021.
//
// ref: https://github.com/Matt54/AudioVisualizerAK5
import Foundation
import AudioKit

class Conductor: ObservableObject{
    
    let engine = AudioEngine()
    
    var mic: AudioEngine.InputNode
    
    let micMixer: Mixer
    
    let silentMixer: Mixer
    
    var fft: FFTTap!
    
    let FFT_SIZE = 2048
    
    let sampleRate: double_t = 44100
    
    let outputLimiter: PeakLimiter
    
    @Published var amplitudes: [Double] = Array(repeating: 0.5, count: 50)
    
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
                self.updateAmplitudes(fftData)
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
    
    func updateAmplitudes(_ fftData: [Float]){
        for i in stride(from : 0, to: self.FFT_SIZE - 1, by: 2){
            let real = fftData[i]
            let imaginary = fftData[i+1]
            
            let normalizedBinMagnitude = 2.0 * sqrt(pow(real, 2) + pow(imaginary, 2)) / Float(self.FFT_SIZE)
            let amplitude = Double(20.0 * log10(normalizedBinMagnitude))
            
            let scaledAmplitude = (amplitude + 250) / 229.80
            
            DispatchQueue.main.async{
                if(i/2 < self.amplitudes.count){
                    var mappedAmplitude = self.map(n: scaledAmplitude, start1: 0.3, stop1: 0.9, start2: 0.0, stop2: 1.0)
                    
                    // restrict to [0,1]
                    if(mappedAmplitude < 0) {
                        mappedAmplitude = 0
                    }
                    
                    if(mappedAmplitude > 1.0){
                        mappedAmplitude = 1.0
                    }
                    
                    self.amplitudes[i/2] = mappedAmplitude
                }
            }
        }
    }
    
    
    // TODO: modify this mapping for our visualization
    func map(n: Double, start1: Double, stop1: Double, start2: Double, stop2: Double) -> Double {
        return ((n-start1)/(stop1-start1)) * (stop2-start2) + start2
    }
}
