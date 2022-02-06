//
//  Audio.swift
//  visualizer
//
//  Created by Andrew Li on 5/2/2022.
//

import Foundation

struct Audio {
    var amplitudes: [Double]
    var peakBarIndex: Int
    var pitchNotation: String
    var pitchFrequency: Float
    var pitchDetune: Float
    var isPitchAccurate: Bool
    
    static let `default` = Audio(
        amplitudes: Array(repeating: 0.5, count: 256),
        peakBarIndex: -1,
        pitchNotation: "-",
        pitchFrequency: 0.0,
        pitchDetune: 0.0,
        isPitchAccurate: false
    )
}
