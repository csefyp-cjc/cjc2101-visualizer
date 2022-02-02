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
    case scroll
    case average
}

class AudioViewModel: ObservableObject{
    // Should be inside audio view model but i don't know how to access in this viewmodel
    @Published var settings: Setting = Setting.default
    
    func changeNoteRepresentationSetting(value: Setting.NoteRepresentation) {
        settings.noteRepresentation = value
    }
    
    func changeNoiseLevelSetting(value: Setting.NoiseLevel) {
        settings.noiseLevel = value
    }
    
    func changeAccuracyLevelSetting(value: Setting.AccuracyLevel) {
        settings.accuracyLevel = value
    }
    // End
    
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
    @Published var amplitudes: [Double] = Array(repeating: 0.5, count: 256)
    @Published var peakBarIndex: Int = -1
    @Published var pitchNotation: String = "-"
    @Published var pitchFrequency: Float = 0.0
    @Published var pitchDetune: Float = 0.0
    @Published var isPitchAccurate: Bool = false
    
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
    
    func updatePitch( pitchFrequency: [Float], amplitude: [Float]) {
        var noiseThreshold: Float = 0.1
        
        switch settings.noiseLevel {
        case .low:
            noiseThreshold = 0.1
        case .medium:
            noiseThreshold = 0.3
        case .high:
            noiseThreshold = 0.5
        }
        
        // TODO: May consider for headphone input (L/R channel)
        if (amplitude[0] > noiseThreshold) {
            self.pitchFrequency = pitchFrequency[0]
            self.pitchNotation = pitchFromFrequency(pitchFrequency[0], settings.noteRepresentation)
            self.pitchDetune = pitchDetuneFromFrequency(pitchFrequency[0])
            self.peakBarIndex = Int(pitchFrequency[0] * Float(self.FFT_SIZE) / Float(self.sampleRate))
            print("🔖 Pitch Detune (Cent)   \(pitchDetune)")
        }
        
        updateIsPitchAccurate()        
    }
    
    func updateAmplitudes(_ fftData: [Float], mode: UpdateMode){
        let binSize = 30
        var bin = Array(repeating: 0.0, count: self.amplitudes.count) // stores amplitude sum
        var noiseThreshold: Double = 0.1
        
        switch settings.noiseLevel {
        case .low:
            noiseThreshold = 0.1
        case .medium:
            noiseThreshold = 0.3
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
                        var mappedAmplitude = self.map(n: scaledAmplitude, start1: 0.3, stop1: 0.9, start2: 0.0, stop2: 1.0)
                        if(mappedAmplitude < noiseThreshold){
                            mappedAmplitude = 0
                        }
                        self.amplitudes[i/2] = self.restrict(value: mappedAmplitude)
                    }
                }
            }
        }
    }
    
    func getPitchIndicatorPosition() -> Int {
        switch pitchDetune {
        case let cent where cent < 0:
            return 4 - Int(abs(pitchDetune) / 12.5)
        case let cent where cent > 0:
            return Int(pitchDetune / 12.5) + 4
        case let cent where cent == 0:
            return 4
        default:
            return 4
        }
    }
    
    func updateIsPitchAccurate() {
        let position = getPitchIndicatorPosition()
        var accuracyPoint: [Int] {
            switch settings.accuracyLevel {
            case .tuning:
                return [4]
            case .practice:
                return [3, 4, 5]
            }
        }
                
        isPitchAccurate = accuracyPoint.contains(position)
    }
    
    
    // TODO: modify this mapping for our visualization
    func map(n: Double, start1: Double, stop1: Double, start2: Double, stop2: Double) -> Double {
        return ((n-start1)/(stop1-start1)) * (stop2-start2) + start2
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
}
