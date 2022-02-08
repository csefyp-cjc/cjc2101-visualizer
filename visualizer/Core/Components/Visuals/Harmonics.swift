//
//  Harmonics.swift
//  visualizer
//
//  Created by Mark Cheng on 8/2/2022.
//

import SwiftUI

struct Harmonics: View {
    
    var harmonics: [Double]
    
    var body: some View {
        VStack{
            HStack{
                ForEach((1...10), id: \.self){i in
                    Spacer()
                    VStack{
                        VBar(val: harmonics[i-1]*7.0, width: 24, color: Color.foundation.secondary, showValue: false)
                    }
                    Spacer()
                }
            }
            Rectangle()
                .fill(Color.neutral.axis)
                .frame(width:.infinity, height: 2)
            HStack{
                ForEach((1...10), id: \.self){i in
                    Spacer()
                    VStack{
                        Text("\(i)").frame(width:24).foregroundColor(.neutral.onAxis)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct Harmonics_Previews: PreviewProvider {
    static var previews: some View {
        Harmonics(harmonics: Array(repeating: 0.5, count: 10))
    }
}
