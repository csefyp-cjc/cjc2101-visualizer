//
//  PitchLetter.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct PitchLetter: View {
//    @State private var pitch = "C"
    var pitchNotation: String
    var pitchFrequency: Float
    
    func format(_ peakFrequency: Float) -> String{
        return String(format: "%.0f Hz", peakFrequency)
    }
        
    var body: some View {
        VStack{
            Text(pitchNotation)
                .font(.system(size: 64, weight:.heavy))
                .foregroundColor(.foundation.primary)
            Text(format(pitchFrequency))
                .font(.label.large)
                .foregroundColor(.foundation.primary)
        }
    }
}

struct PitchIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PitchLetter(pitchNotation: "A4", pitchFrequency: 440)
    }
}
