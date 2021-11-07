//
//  Frequencies.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct Frequencies: View {
    @GestureState private var isPressed = false
    
    let drag = DragGesture(minimumDistance: 0)
    

    var body: some View {
        HStack(spacing: 5){
            ForEach(0...48, id: \.self){ i in
                VBar(x: Int.random(in: 10..<48))
            }
        }
    }
}

struct Frequencies_Previews: PreviewProvider {
    static var previews: some View {
        Frequencies()
    }
}
