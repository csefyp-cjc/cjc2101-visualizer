//
//  visualizerApp.swift
//  visualizer-watch WatchKit Extension
//
//  Created by Andrew Li on 7/2/2022.
//

import SwiftUI

@main
struct visualizerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
