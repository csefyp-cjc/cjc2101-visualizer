//
//  Frequencies.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct Frequencies: View {
    @GestureState private var isPressed = false
    var amplitudes: [Double]
    
    let drag = DragGesture(minimumDistance: 0)

    var body: some View {
        HStack(spacing: 5){
            ForEach(0...48, id: \.self){ i in
                VBar(x: amplitudes[i]*10.0)
            }
        }
    }
}

struct Frequencies_Previews: PreviewProvider {
    static var previews: some View {
        Frequencies(amplitudes: Array(repeating: 0.5, count: 50))
    }
}
