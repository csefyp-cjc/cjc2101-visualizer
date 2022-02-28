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
        GeometryReader { geometry in
            VStack{
                HStack{
                    ForEach((1...harmonics.count), id: \.self){i in
                        Spacer()
                        
                        VStack{
                            VBar(val: harmonics[i-1]*7.0,
                                 width: Int(geometry.size.width) / (harmonics.count + harmonics.count / 2),
                                 color: isReference ? Color.accent.highlight.opacity(0.4) : Color(red: 0.9607843137, green: 0.2039215686, blue: 0.2039215686, opacity: 1),
                                 showValue: false
                            )
                        }
                        if (i == harmonics.count) {
                            Spacer()
                        }
                    }
                }
                
                Rectangle()
                    .fill(Color.neutral.axis)
                    .frame(width: .infinity, height: 2)
                
                HStack{
                    ForEach((1...harmonics.count), id: \.self){i in
                        Spacer()
                        VStack{
                            Text("\(i)")
                                .frame(width: 18)
                                .foregroundColor(.neutral.onAxis)
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height,
                   alignment: .bottom)
        }
    }
}

struct FixedSpacer: View {
    var body: some View {
        Spacer()
            .frame(minWidth: 4, idealWidth: 7, maxWidth: 10)
            .fixedSize()
    }
}

struct Harmonics_Previews: PreviewProvider {
    static var previews: some View {
        Harmonics(harmonics: Array(repeating: 0.5, count: 12),
            isReference: false
        )
    }
}
