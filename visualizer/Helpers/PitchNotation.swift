//
//  PitchNotation.swift
//  visualizer
//
//  Created by Andrew Li on 20/11/2021.
//

import Foundation

let A4: Float = 440
let C0 = A4 * pow(2, -4.75)

// TODO: Notation for different Key
let notation = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]

func pitchFromFrequency(frequency: Float) -> String{
    if (frequency > C0) {
        let h:Int = Int(round(12 * log2(frequency / C0)))
        let octave = h / 12
        let n = h % 12
        
        return notation[n] + String(octave)
    } else {
        return "-"
    }
    
}
