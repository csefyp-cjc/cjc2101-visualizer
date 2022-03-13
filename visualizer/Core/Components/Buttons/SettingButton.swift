//
//  SettingButton.swift
//  visualizer
//
//  Created by Andrew Li on 25/11/2021.
//

import SwiftUI

struct SettingButton<T: RawRepresentable & CaseIterable>: View {
    var label: String
    var type: T.Type
    var selected: Bool
    var action: (T) -> Void
    
    var body: some View {
        Button {
            self.action(T(rawValue: self.label as! T.RawValue) ?? T.allCases.first!)
        } label: {
            Text(self.label)
                .font(self.type == Setting.NoteRepresentation.self ? .label.medium : .label.xsmall)
                .foregroundColor(selected ? .foundation.onPrimary : .neutral.onSurface)
                .padding(self.type == Setting.NoteRepresentation.self ?
                         EdgeInsets(top: 8, leading: 36, bottom: 8, trailing: 36) :
                            EdgeInsets(top: 12, leading: 28, bottom: 12, trailing: 28)
                )
                .background(selected ? Color.foundation.primary : Color.neutral.surface)
                .cornerRadius(8)
        }
        
    }
}

struct SettingButton_swift_Previews: PreviewProvider {
    static var previews: some View {
        SettingButton(label: Setting.NoteRepresentation.sharp.rawValue,
                      type: Setting.NoteRepresentation.self,
                      selected: true,
                      action: AudioViewModel().settingVM.changeNoteRepresentationSetting
        )
        
        SettingButton(label: Setting.NoiseLevel.medium.rawValue,
                      type: Setting.NoiseLevel.self,
                      selected: false,
                      action: AudioViewModel().settingVM.changeNoiseLevelSetting
        )
    }
    
}
