//
//  PitchLetter.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct PitchLetter: View {
//    @State private var pitch = "C"
    var peakFrequency: Float
    
    func toPitch(_ peakFrequency: Float) -> String {
        // TODO: mapping freq-pitch table
        return "A"
    }
    
    func format(_ peakFrequency: Float) -> String{
        return String(format: "%.2f Hz", peakFrequency)
    }
    
    
    var body: some View {
        VStack{
            Text(toPitch(self.peakFrequency))
                .font(.system(size: 64, weight:.heavy))
                .foregroundColor(.foundation.primary)
            Text(format(self.peakFrequency))
                .font(.label.large)
                .foregroundColor(.foundation.primary)
        }
    }
}

struct PitchIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PitchLetter(peakFrequency: 440.0)
    }
}
