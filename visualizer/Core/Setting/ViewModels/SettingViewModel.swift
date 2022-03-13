//
//  SettingViewModel.swift
//  visualizer
//
//  Created by Andrew Li on 28/11/2021.
//

import Foundation
import SwiftUI

class SettingViewModel: ObservableObject{
    @Published var settings: Setting
    var systemColorScheme: ColorScheme = .light
    
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
    
    func changeAppearanceSetting(_ value: Setting.Appearance) {
        self.settings.appearance = value
        self.storeSettings()
    }
    
    func getScheme () -> ColorScheme? {
        switch self.settings.appearance {
        case .system:
            return self.systemColorScheme
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
    
    func isSelected(label: String, type: String) -> Bool {
        switch type {
        case "noteRepresentation":
            return label == self.settings.noteRepresentation.rawValue
        case "noiseLevel":
            return label == self.settings.noiseLevel.rawValue
        case "accuracyLevel":
            return label == self.settings.accuracyLevel.rawValue
        case "appearance":
            return label == self.settings.appearance.rawValue
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
