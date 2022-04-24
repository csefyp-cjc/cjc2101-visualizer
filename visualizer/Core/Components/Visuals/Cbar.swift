//
//  Cbar.swift
//  visualizer
//
//  Created by Mark Cheng on 25/4/2022.
//

import SwiftUI

struct Cbar: View {
    let val: Double // val that it represents ( for height calculation )
    let width: Int
    let color: Color
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .frame(width: CGFloat(width), height: CGFloat(50 * val))
                .cornerRadius(4)
                .frame(maxHeight: 450, alignment: .center)
                .animation(.easeOut(duration: 0.15))
        }
    }
}

struct Cbar_Previews: PreviewProvider {
    static var previews: some View {
        Cbar(val: 1, width: 1, color: Color.red)
    }
}
