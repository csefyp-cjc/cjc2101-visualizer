//
//  VBar.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct VBar: View {
    let x: Int
    
    var body: some View {
        Rectangle().fill(Color("secondary")).frame(width: 4, height: CGFloat(5 * x)).frame(maxHeight: 350, alignment: .bottom)
    }
}

struct VBar_Previews: PreviewProvider {
    static var previews: some View {
        VBar(x: 20).previewLayout(.fixed(width: 4, height: 300))
    }
}
