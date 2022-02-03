//
//  Typography.swift
//  visualizer
//
//  Created by Andrew Li on 9/11/2021.
//

import SwiftUI

extension Font {
    static let heading = Heading()
    static let label = Label()
    static let text = Text()
    
    struct Heading {
        let small = Font.system(size: 18).weight(.semibold)
    }
    
    struct Label {
        let large = Font.system(size: 18).weight(.medium)
        let medium = Font.system(size: 16).weight(.medium)
        let small = Font.system(size: 14).weight(.medium)
        let xsmall = Font.system(size: 12).weight(.medium)
    }
    
    struct Text {
        let paragraph = Font.system(size: 14).weight(.medium)
      
    }
}
