//
//  SettingViewModel.swift
//  visualizer
//
//  Created by Andrew Li on 28/11/2021.
//

import Foundation

class SettingViewModel: ObservableObject{
    @Published var settings: Setting = Setting.default
    
    func changeNoteRepresentationSetting(value: Setting.NoteRepresentation) {
        settings.noteRepresentation = value
    }
    
    func changeNoiseLevelSetting(value: Setting.NoiseLevel) {
        settings.noiseLevel = value
    }
    
    func changeAccuracyLevelSetting(value: Setting.AccuracyLevel) {
        settings.accuracyLevel = value
    }
}
