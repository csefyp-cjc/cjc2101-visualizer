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
    var isMixed: Bool
    
    func getWidth(_ width: CGFloat) -> CGFloat {
        let divider = harmonics.count + harmonics.count / 2
        return width / CGFloat(divider)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    ForEach((1...harmonics.count), id: \.self) { i in
                        Spacer()
                        
                        if (!isMixed) {
                            VStack {
                                VBar(val: harmonics[i-1]*7.0,
                                     width: Int(getWidth(geometry.size.width)),
                                     color: isReference ? Color.accent.highlightVariant : Color.accent.highlight,
                                     showValue: false
                                )
                            }
                        } else {
                            VStack {
                                ReferenceBar(val: harmonics[i-1]*7.0,
                                             width: Int(getWidth(geometry.size.width)),
                                             color: Color.accent.highlightVariant,
                                             showValue: false
                                )
                            }
                        }
                        
                        if (i == harmonics.count) {
                            Spacer()
                        }
                    }
                }
                
                Rectangle()
                    .fill(Color.neutral.axis)
                    .frame(width: .infinity, height: 2)
                
                HStack {
                    ForEach((1...harmonics.count), id: \.self) { i in
                        Spacer()
                        VStack {
                            Text("\(i)")
                                .frame(width: getWidth(geometry.size.width))
                                .foregroundColor(.neutral.onAxis)
                        }
                        if (i == harmonics.count) {
                            Spacer()
                        }
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
                  isReference: false,
                  isMixed: false
        )
    }
}
