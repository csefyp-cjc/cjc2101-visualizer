//
//  SettingButton.swift
//  visualizer
//
//  Created by Andrew Li on 25/11/2021.
//

import SwiftUI

struct SettingButton: View {
    var label: String
    var type: String
    var selected: Bool
    var changeNoteRepresentationSetting: (Setting.NoteRepresentation) -> Void
    var changeNoiseLevelSetting: (Setting.NoiseLevel) -> Void
    var changeAccuracyLevelSetting: (Setting.AccuracyLevel) -> Void
            
    var body: some View {
        Button {
            switch self.type {
            case "noteRepresentation":
                self.changeNoteRepresentationSetting(Setting.NoteRepresentation(rawValue: self.label) ?? Setting.NoteRepresentation.sharp)
            case "noiseLevel":
                self.changeNoiseLevelSetting(Setting.NoiseLevel(rawValue: self.label) ?? Setting.NoiseLevel.low)
            case "accuracyLevel":
                self.changeAccuracyLevelSetting(Setting.AccuracyLevel(rawValue: self.label) ?? Setting.AccuracyLevel.tuning)
            default:
                print("Error: Invaild function for SettingButton")
            }
        } label: {
            Text(self.label)
                .font(self.type == "noteRepresentation" ? .label.medium : .label.xsmall)
                .foregroundColor(selected ? .foundation.onPrimary : .neutral.onSurface)
                .padding(self.type == "noteRepresentation" ?
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
                      type: "noteRepresentation",
                      selected: true,
                      changeNoteRepresentationSetting: AudioViewModel().settingVM.changeNoteRepresentationSetting,
                      changeNoiseLevelSetting: AudioViewModel().settingVM.changeNoiseLevelSetting,
                      changeAccuracyLevelSetting: AudioViewModel().settingVM.changeAccuracyLevelSetting
        )
                
        SettingButton(label: Setting.NoiseLevel.medium.rawValue,
                      type: "noiseLevel",
                      selected: false,
                      changeNoteRepresentationSetting: AudioViewModel().settingVM.changeNoteRepresentationSetting,
                      changeNoiseLevelSetting: AudioViewModel().settingVM.changeNoiseLevelSetting,
                      changeAccuracyLevelSetting: AudioViewModel().settingVM.changeAccuracyLevelSetting)
            
    }
        
}
