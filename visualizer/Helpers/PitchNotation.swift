//
//  PitchNotation.swift
//  visualizer
//
//  Created by Andrew Li on 20/11/2021.
//

import Foundation

let A4: Float = 440
let C0: Float = A4 * pow(2, -4.75)

// TODO: Notation for different Key
let notation = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]

func pitchFromFrequency(_ frequency: Float) -> String{
    if (frequency > C0) {
        let steps: Int = Int(round(12 * log2(frequency / C0)))   // Number of semitone from C0 to frequency
        let octave = steps / 12
        let n = steps % 12
        
        return notation[n] + String(octave)
    } else {
        return "-"
    }
}

func pitchDetuneFromFrequency(_ frequency: Float) -> Float {
    if (frequency > C0) {
        let steps: Int = Int(round(12 * log2(frequency / C0)))   // Number of semitone from C0 to frequency
        
        let nearestNoteFrequency =  pow(2, Float(steps) / 12) * C0
        let nearestHigherNoteFrequency =  pow(2, Float(steps + 1) / 12) * C0
        let nearestLowerNoteFrequency =  pow(2, Float(steps - 1) / 12) * C0
        
        let sharp = frequency > nearestNoteFrequency
        let flat = frequency < nearestNoteFrequency
        
        if (sharp) {
            let cent = (nearestHigherNoteFrequency - nearestNoteFrequency) / 100
            return (frequency - nearestNoteFrequency) / cent
        } else if (flat) {
            let cent = (nearestNoteFrequency - nearestLowerNoteFrequency) / 100
            return -((nearestNoteFrequency - frequency) / cent)
        }
        
        return nearestNoteFrequency
    } else {
        return 0
    }
        
}
