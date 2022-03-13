//
//  Setting.swift
//  visualizer
//
//  Created by Andrew Li on 28/11/2021.
//

import Foundation
import SwiftUI

struct Setting: Codable {
    var noteRepresentation: NoteRepresentation
    var noiseLevel: NoiseLevel
    var accuracyLevel: AccuracyLevel
    var appearance: Appearance
    
    static let `default` = Setting(
        noteRepresentation: NoteRepresentation.sharp,
        noiseLevel: NoiseLevel.low,
        accuracyLevel: AccuracyLevel.tuning,
        appearance: Appearance.system
    )
    
    enum NoteRepresentation: String, CaseIterable, Identifiable, Codable {
        case sharp = "♯"
        case flat = "♭"
        
        var id: String { rawValue }
    }
    
    enum NoiseLevel: String, CaseIterable, Identifiable, Codable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        
        var id: String { rawValue }
        
        func getDescription () -> String {
            switch self {
            case .low:
                return "A quiet place, like your bedroom or a practice room"
            case .medium:
                return "A place with a higher background noise"
            case .high:
                return "Outdoor or noisy environment"
            }
        }
    }
    
    enum AccuracyLevel: String, CaseIterable, Identifiable, Codable {
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
    
    enum Appearance: String, CaseIterable, Identifiable, Codable {
        case system = "System"
        case dark = "Dark"
        case light = "Light"
        
        var id: String { rawValue }
        
        func getDescription () -> String {
            switch self {
            case .system:
                return "Use system setting"
            case .dark:
                return "Use dark appearance"
            case .light:
                return "Use light appearance"
            }
        }
    }
}

extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
