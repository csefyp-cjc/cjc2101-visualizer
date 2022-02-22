//
//  Harmonics.swift
//  visualizer
//
//  Created by Mark Cheng on 8/2/2022.
//

import SwiftUI

struct Harmonics: View {
    
    var harmonics: [Double]
    var isReference: Bool
    
    var body: some View {
        VStack{
            HStack{
                ForEach((1...harmonics.count), id: \.self){i in
                    Spacer()
                    VStack{
                        VBar(val: harmonics[i-1]*7.0,
                             width: 24,
                             color: isReference ? Color.accent.highlight.opacity(0.4) : Color(red: 0.9607843137, green: 0.2039215686, blue: 0.2039215686, opacity: 1),
                             showValue: false
                        )
                    }
                    Spacer()
                }
            }
            Rectangle()
                .fill(Color.neutral.axis)
                .frame(width:.infinity, height: 2)
            HStack{
                ForEach((1...harmonics.count), id: \.self){i in
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
        Harmonics(harmonics: Array(repeating: 0.5, count: 10),
            isReference: false
        )
    }
}
