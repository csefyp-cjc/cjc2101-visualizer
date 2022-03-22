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
    
    struct Foundation {
        let primary: Color = Color("primary")
        let onPrimary: Color = Color("onPrimary")
        let secondary: Color = Color("secondary")
    }
    
    struct Accent {
        let error: Color = Color("error")
        let success: Color = Color("success")
        let successVariant: Color = Color("successVariant")
        let successContainer = Color("successContainer")
        let highlight: Color = Color("highlight")
        let highlightVariant: Color = Color("highlightVariant")
        let disabled: Color = Color("disabled")
    }
    
    struct Neutral {
        let background = Color("background")
        let onBackground = Color("onBackground")
        let onBackgroundVariant = Color("onBackgroundVariant")
        let surface = Color("surface")
        let onSurface = Color("onSurface")
        let axis = Color("axis")
        let onAxis = Color("onAxis")
        let overlay = Color("overlay")
    }
}


