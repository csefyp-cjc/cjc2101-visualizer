//
//  Setting.swift
//  visualizer
//
//  Created by Andrew Li on 28/11/2021.
//

import Foundation

struct Setting {
    var noteRepresentation: NoteRepresentation = NoteRepresentation.sharp
    var noiseLevel: NoiseLevel = NoiseLevel.low
    var accuracyLevel: AccuracyLevel = AccuracyLevel.tuning
    
    static let `default` = Setting()
    
    enum NoteRepresentation: String, CaseIterable, Identifiable {
        case sharp = "♯"
        case flat = "♭"
        
        var id: String { rawValue }
    }
    
    enum NoiseLevel: String, CaseIterable, Identifiable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        
        var id: String { rawValue }
        
        func getDescription () -> String {
            switch self {
            case .low:
                return "A quite place, like your bedroom or a practice room"
            case .medium:
                return "A place with a higher background noise"
            case .high:
                return "Outdoor or noisy environment"
            }
        }
    }
    
    enum AccuracyLevel: String, CaseIterable, Identifiable {
        case tuning = "Tuning"
        case practice = "Practice"
        
        var id: String { rawValue }
        
        func getDescription () -> String {
            switch self {
            case .tuning:
                return "Precise tuning for setting up"
            case .practice:
                return "Show the detune of note played"
            }
        }
    }
}
