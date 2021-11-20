//
//  VBar.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct VBar: View {
    let x: Double
    
    var body: some View {
        Rectangle()
            .fill(Color.foundation.secondary)
            .frame(width: 4, height: CGFloat(50 * x))
            .frame(maxHeight: 350, alignment: .bottom)
            .animation(.easeOut(duration: 0.15))
    }
}

struct VBar_Previews: PreviewProvider {
    static var previews: some View {
        VBar(x: 20).previewLayout(.fixed(width: 4, height: 300))
    }
}
