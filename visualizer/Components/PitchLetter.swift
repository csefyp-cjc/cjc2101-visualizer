//
//  PitchLetter.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct PitchLetter: View {
    @EnvironmentObject var audioViewModel: AudioViewModel
    
    //    @State private var pitch = "C"
    var pitchNotation: String
    var pitchFrequency: Float
    
    func format(_ peakFrequency: Float) -> String{
        if (peakFrequency < 0.0) {
            return "-"
        } else {
            return String(format: "%.0f Hz", peakFrequency)
        }
    }
    
    var body: some View {
        VStack{
            Button {
                // Change pitch notation setting
                audioViewModel.changeNoteRepresentationSetting(value: audioViewModel.settings.noteRepresentation.next())
                
                // Update pitch notation of pitch letter
                audioViewModel.pitchNotation = changePitchNotation(pitchNotation)
            } label: {
                Text(pitchNotation)
                    .font(.system(size: 64, weight:.heavy))
                    .foregroundColor(.foundation.primary)
            }
            Text(format(pitchFrequency))
                .font(.label.large)
                .foregroundColor(.foundation.primary)            
        }
    }
}

struct PitchIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PitchLetter(pitchNotation: "A4", pitchFrequency: 440)
            .environmentObject(AudioViewModel())
    }
}
