//
//  PitchLetter.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct PitchLetter: View {
    @EnvironmentObject var settingViewModel: SettingViewModel
    @Binding var pitchNotation: String
    var noteRepresentation: Setting.NoteRepresentation
    var changeNoteRepresentationSetting: (Setting.NoteRepresentation) -> Void
    
    var body: some View {
        VStack{
            Button {
                changeNoteRepresentationSetting(noteRepresentation.next())
                pitchNotation = changePitchNotation(pitchNotation)
            } label: {
                Text(pitchNotation)
                    .font(.system(size: 64, weight:.heavy))
                    .foregroundColor(.foundation.primary)
            }        
        }
    }
}

struct PitchIndicator_Previews: PreviewProvider {
    @State static private var pitchNotation = "A4"
    
    static var previews: some View {
        PitchLetter(pitchNotation: $pitchNotation,
                    noteRepresentation: Setting.NoteRepresentation.sharp,
                    changeNoteRepresentationSetting: SettingViewModel().changeNoteRepresentationSetting
        )
    }
}
