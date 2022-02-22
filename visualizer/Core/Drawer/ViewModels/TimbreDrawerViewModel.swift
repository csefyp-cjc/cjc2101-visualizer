//
//  TimbreDrawerViewModel.swift
//  visualizer
//
//  Created by Mark Cheng on 15/2/2022.
//

import Foundation

class TimbreDrawerViewModel: ObservableObject{
    @Published var timbreDrawer: TimbreDrawer
    
    init() {
        self.timbreDrawer = TimbreDrawer.default                
    }
    
    func isSelected(_ type: TimbreDrawer.InstrumentTypes) -> Bool {
        return type == self.timbreDrawer.selected
    }
    
}
