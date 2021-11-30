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
    var peakBarIndex: Int
    var match: Bool
    let drag = DragGesture(minimumDistance: 0)

    var body: some View {
        ScrollView(.horizontal){
            ScrollViewReader{ proxy in
                HStack(spacing: 5){
                    ForEach(0...amplitudes.count-1, id: \.self){ i in
                        if(match){
                            VBar(x: amplitudes[i]*10.0, color: .accent.successVariant)
                        }else{
                            VBar(x: amplitudes[i]*10.0, color: .foundation.secondary)
                        }
                    }
                }.onChange(of: peakBarIndex){ value in
                    withAnimation{
                        proxy.scrollTo(value, anchor: .center)
                    }
                }
            }
        }
    }
}

struct Frequencies_Previews: PreviewProvider {
    static var previews: some View {
        Frequencies(amplitudes: Array(repeating: 0.5, count: 256), peakBarIndex: -1, match: true)
    }
}
