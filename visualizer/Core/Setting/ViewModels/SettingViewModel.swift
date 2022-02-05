//
//  SettingViewModel.swift
//  visualizer
//
//  Created by Andrew Li on 28/11/2021.
//

import Foundation

class SettingViewModel: ObservableObject{
    @Published var settings: Setting = Setting.default
    
    func changeNoteRepresentationSetting(_ value: Setting.NoteRepresentation) {
        self.settings.noteRepresentation = value
    }
    
    func changeNoiseLevelSetting(_ value: Setting.NoiseLevel) {
        self.settings.noiseLevel = value
    }
    
    func changeAccuracyLevelSetting(_ value: Setting.AccuracyLevel) {
        self.settings.accuracyLevel = value
    }
    
    func isSelected(label: String, type: String) -> Bool {
        switch type {
        case "noteRepresentation":
            return label == self.settings.noteRepresentation.rawValue
        case "noiseLevel":
            return label == self.settings.noiseLevel.rawValue
        case "accuracyLevel":
            return label == self.settings.accuracyLevel.rawValue
        default:
            print("Error: Invaild function for SettingButton")
            return false
        }
    }
}
