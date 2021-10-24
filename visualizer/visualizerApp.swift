//
//  visualizerApp.swift
//  visualizer
//
//  Created by Mark Cheng on 10/10/2021.
//

import SwiftUI

@main
struct visualizerApp: App {
    
    @StateObject var audio = AudioModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(audio)
        }
    }
}
