//
//  InteractiveTutorialViewModel.swift
//  visualizer
//
//  Created by Andrew Li on 4/2/2022.
//

import Foundation
import SwiftUI

class InteractiveTutorialViewModel: ObservableObject {
    @Published var tutorials: [InteractiveTutorial] =  [
        InteractiveTutorial(text: "Pitch and frequencies are correlated. The x-axis here is the letter name of musical notes.",
                            textPosition: CGSize(width: (UIScreen.main.bounds.width - 32) / 2,
                                                 height: UIScreen.main.bounds.height - 250),
                            size: CGSize(width: UIScreen.main.bounds.width - 16, height: 28),
                            offset: CGSize(width: 0, height: UIScreen.main.bounds.height / 2 - 92)),
        InteractiveTutorial(text: "The bars indicidates the distribution of the frequencies.",
                            textPosition: CGSize(width: (UIScreen.main.bounds.width - 32) / 2,
                                                 height: UIScreen.main.bounds.height / 2 - 120),
                            size: CGSize(width: UIScreen.main.bounds.width, height: 340),
                            offset: CGSize(width: 0, height: 176))]
    @Published var currentPage: Int = 0
    
    // Return true to dismiss tutorial
    func handleNextInstruction() -> Bool {
        if (self.currentPage < self.tutorials.count - 1) {
            self.currentPage += 1
            return false
        } else {
            self.currentPage = 0
            return true
        }
    }

}
