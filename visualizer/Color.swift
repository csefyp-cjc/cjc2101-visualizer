//
//  Color.swift
//  visualizer
//
//  Created by Andrew Li on 8/11/2021.
//

import SwiftUI

extension Color {    
    static let foundation = Foundation()
    static let accent = Accent()
    static let neutral = Neutral()
    static let background = Background()
    
    struct Foundation {
        let primary: Color = Color("primary")
        let onPrimary: Color = Color("onPrimary")
        let secondary: Color = Color("secondary")
    }
    
    struct Accent {
        let error: Color = Color("error")
        let success: Color = Color("success")
        let highlight: Color = Color("highlight")
    }
    
    struct Neutral {
        let axis = Color("axis")
        let onAxis = Color("onAxis")
    }
    
    struct Background {
        let bgPrimary = Color("bgPrimary")
        let bgSecondary = Color("bgSecondary")
        let bgSuccess = Color("bgSuccess")
    }
}


