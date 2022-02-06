//
//  SettingViewModel.swift
//  visualizer
//
//  Created by Andrew Li on 28/11/2021.
//

import Foundation

class SettingViewModel: ObservableObject{
    @Published var settings: Setting
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: "settings"),
              let decodedSettings = try? JSONDecoder().decode(Setting.self, from: data)
        else {
            self.settings = Setting.default
            return
        }
        self.settings = decodedSettings
    }
                
    
    func changeNoteRepresentationSetting(_ value: Setting.NoteRepresentation) {
        self.settings.noteRepresentation = value
        self.storeSettings()
    }
    
    func changeNoiseLevelSetting(_ value: Setting.NoiseLevel) {
        self.settings.noiseLevel = value
        self.storeSettings()
    }
    
    func changeAccuracyLevelSetting(_ value: Setting.AccuracyLevel) {
        self.settings.accuracyLevel = value
        self.storeSettings()
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
        
    private func storeSettings() {
        if let encodedSettings = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encodedSettings, forKey: "settings")
        }
    }
}
