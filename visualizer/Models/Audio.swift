//
//  Audio.swift
//  visualizer
//
//  Created by Andrew Li on 5/2/2022.
//

import Foundation

struct Audio {
    var amplitudes: [Double] // realtime amplitudes
    var amplitudesToDisplay: [Double] // amplitudes on change by some event(e.g., pitch change)
    var peakBarIndex: Int
    var pitchNotation: String
    var pitchFrequency: Float
    var pitchDetune: Float
    var isPitchAccurate: Bool
    let totalHarmonics: Int
    var harmonicAmplitudes: [Double]
    var audioFeatures: AudioFeatures
    
    
    
    static let `default` = Audio(
        amplitudes: Array(repeating: 0.5, count: 256),
        amplitudesToDisplay: Array(repeating: 0.5, count: 256),
        peakBarIndex: -1,
        pitchNotation: "-",
        pitchFrequency: 0.0,
        pitchDetune: 0.0,
        isPitchAccurate: false,
        totalHarmonics: 12,
        harmonicAmplitudes: Array(repeating: 0.5, count: 12),
        audioFeatures: AudioFeatures(spectralCentroid: 0, inharmonicity: 0, quality: 0)
    )
}

struct AudioFeatures {
    var spectralCentroid: Double
    var inharmonicity: Double
    var quality: Double
}

enum AudioFeature: String, CaseIterable, Identifiable, Codable {
    case spectralCentroid = "Brightness"
    case inharmonicity = "Inharmonicity"
    case quality = "Quality"
    
    var id: String { rawValue }
    
    func getDescription () -> String {
        switch self {
        case .spectralCentroid:
            return "Brightness describes your tone color"
        case .inharmonicity:
            return "Inharmonic describes how the overtones is out of tune"
        case .quality:
            return "Quality describes whether your sound is full or hollow"
        }
    }
    
    func getLabels () -> (String, String) {
        switch self {
        case .spectralCentroid:
            return ("Dark/warm", "Bright")
        case .inharmonicity:
            return ("Inharmonic", "Harmonic")
        case .quality:
            return ("Hollow", "Full")
        }
        
    }
}
