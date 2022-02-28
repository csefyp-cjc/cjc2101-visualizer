//
//  InteractiveTutorialViewModel.swift
//  visualizer
//
//  Created by Andrew Li on 4/2/2022.
//

import Foundation
import SwiftUI

class InteractiveTutorialViewModel: ObservableObject {
    @Published var tutorials: [InteractiveTutorial]
    @Published var currentPage: Int = 0
    var page: InteractiveTutorial.Page
    
    init(page: InteractiveTutorial.Page) {
        self.page = page
        switch self.page {
        case .pitch:
            self.tutorials = [
                InteractiveTutorial(text: "Pitch and frequencies are correlated. The x-axis here is the letter name of musical notes.",
                                    textPosition: CGSize(width: (UIScreen.main.bounds.width - 32) / 2,
                                                         height: UIScreen.main.bounds.height - 250),
                                    size: CGSize(width: UIScreen.main.bounds.width - 16, height: 28),
                                    offset: CGSize(width: 0, height: UIScreen.main.bounds.height / 2 - 92)),
                InteractiveTutorial(text: "The bars indicidate the distribution of the frequencies.",
                                    textPosition: CGSize(width: (UIScreen.main.bounds.width - 32) / 2,
                                                         height: UIScreen.main.bounds.height / 2 - 120),
                                    size: CGSize(width: UIScreen.main.bounds.width, height: 340),
                                    offset: CGSize(width: 0, height: 176))]
        case .timbre:
            self.tutorials = [
                InteractiveTutorial(text: "Timbre describes your tone color or tone quality.",
                                    textPosition: CGSize(width: (UIScreen.main.bounds.width - 32) / 2,
                                                         height: UIScreen.main.bounds.height / 2 - 40),
                                    size: CGSize(width: 0, height: 0),
                                    offset: CGSize(width: 0, height: 0)),
                InteractiveTutorial(text: "The x-axis here is the harmonics number. The 1st harmonic is your fundamental frequency.",
                                    textPosition: CGSize(width: (UIScreen.main.bounds.width - 32) / 2,
                                                         height: UIScreen.main.bounds.height - 250),
                                    size: CGSize(width: UIScreen.main.bounds.width - 16, height: 28),
                                    offset: CGSize(width: 0, height: UIScreen.main.bounds.height / 2 - 92)),
                InteractiveTutorial(text: "The bars indicidate the strength distribution of the harmonics.",
                                    textPosition: CGSize(width: (UIScreen.main.bounds.width - 32) / 2,
                                                         height: UIScreen.main.bounds.height / 2 - 120),
                                    size: CGSize(width: UIScreen.main.bounds.width, height: 340),
                                    offset: CGSize(width: 0, height: 176)),
                InteractiveTutorial(text: "We provide references from professional sound samples for your selected instrument. \n\nYou may try to adjust your expression and technique to achieve better tone quality.",
                                    textPosition: CGSize(width: (UIScreen.main.bounds.width - 32) / 2,
                                                         height: UIScreen.main.bounds.height / 2 - 120),
                                    size: CGSize(width: UIScreen.main.bounds.width, height: 340),
                                    offset: CGSize(width: 0, height: 176))]
        }
        
    }
    
    // Return true to dismiss tutorial
    func handleNextInstruction() -> Bool {
        guard self.currentPage < self.tutorials.count - 1 else {
            return true
        }
        
        self.currentPage += 1
        return false
    }
    
}
