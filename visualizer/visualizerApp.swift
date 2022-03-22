//
//  visualizerApp.swift
//  visualizer
//
//  Created by Mark Cheng on 10/10/2021.
//

import SwiftUI

@main
struct visualizerApp: App {
    @StateObject var audioViewModel = AudioViewModel()
    @StateObject var watchConnectivityViewModel = WatchConnectivityViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioViewModel)
                .environmentObject(watchConnectivityViewModel)
                .onChange(of: audioViewModel.audio.pitchNotation) { value in
                    watchConnectivityViewModel.sendPitchNotation(pitchNotation: value)
                }
        }
    }
}
