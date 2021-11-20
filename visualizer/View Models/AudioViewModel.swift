//
//  AudioViewModel.swift
//  visualizer
//
//  Created by Mark Cheng on 19/11/2021.
//
// ref: https://github.com/Matt54/AudioVisualizerAK5

import Foundation
import AudioKit
import SoundpipeAudioKit

enum UpdateMode{
    case limited
    case average
}

class AudioViewModel: ObservableObject{
    
    var isStarted: Bool = false
    
    let engine = AudioEngine()
    
    var mic: AudioEngine.InputNode
    
    let fftMixer: Mixer
    
    let pitchMixer: Mixer
    
    let silentMixer: Mixer
    
    var taps: [BaseTap] = []
    
    let FFT_SIZE = 2048
    
    let sampleRate: double_t = 44100
    
    let outputLimiter: PeakLimiter

    // TODO: May change this with array model when our audio model not only containing amplitude arrayM
    @Published var amplitudes: [Double] = Array(repeating: 0.5, count: 50)
    @Published var peakFrequency: Float = 0.0
    
    @Published var pitchNotation: String = ""
    @Published var pitchFrequency: Float = 0.0
 
    init(){
        // TODO: test no microphone priviledge
        guard let input = engine.input else{
            fatalError()
        }
        
        mic = input

        fftMixer = Mixer(mic)
        pitchMixer = Mixer(fftMixer)
        silentMixer = Mixer(pitchMixer)
        outputLimiter = PeakLimiter(silentMixer)
        
        engine.output = outputLimiter
                    
        taps.append(FFTTap(fftMixer){ fftData in
            DispatchQueue.main.async{
                self.updateAmplitudes(fftData, mode: .limited)
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
    

    func updatePitch( pitchFrequency: [Float], amplitude: [Float]) {
        self.pitchFrequency = pitchFrequency[0]
        self.pitchNotation = pitchFromFrequency(frequency: pitchFrequency[0])
    }
    
    func updateAmplitudes(_ fftData: [Float], mode: UpdateMode){
        let binSize = 30
        var bin = Array(repeating: 0.0, count: self.amplitudes.count) // stores amplitude sum
    
        for i in stride(from : 0, to: self.FFT_SIZE - 1, by: 2){
            let real = fftData[i]
            let imaginary = fftData[i+1]
            
            let normalizedMagnitude = 2.0 * sqrt(pow(real, 2) + pow(imaginary, 2)) / Float(self.FFT_SIZE)
            let amplitude = Double(20.0 * log10(normalizedMagnitude))
            
            let scaledAmplitude = (amplitude + 250) / 229.80

            if(mode == .average){
                if(i/binSize < self.amplitudes.count){
                    bin[i/binSize] = bin[i/binSize] + restrict(value: scaledAmplitude)
                }
                
                DispatchQueue.main.async {
                    if(i%binSize == 0 && i/binSize < self.amplitudes.count){
                        self.amplitudes[i/binSize] = bin[i/binSize] / Double(binSize)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    if(i/2 < self.amplitudes.count){
                        self.amplitudes[i/2] = self.map(n: scaledAmplitude, start1: 0.3, stop1: 0.9, start2: 0.0, stop2: 1.0)
                    }
                }
            }
        }
    }
    
    
    // TODO: modify this mapping for our visualization
    func map(n: Double, start1: Double, stop1: Double, start2: Double, stop2: Double) -> Double {
        return restrict(value: ((n-start1)/(stop1-start1)) * (stop2-start2) + start2)
    }
    
    func restrict(value: Double) -> Double {
        if(value < 0.0) {
            return 0
        }
        if(value > 1.0){
            return 1.0
        }
        return value
    }
    
    func toggle() {
        if(self.isStarted){
            engine.stop()
            taps.forEach{ tap in
                tap.stop()
            }
        }else{
            do{
                try engine.start()
                taps.forEach{ tap in
                    tap.start()
                }
            }catch{
                assert(false, error.localizedDescription)
            }
        }
        self.isStarted.toggle()
    }
}
