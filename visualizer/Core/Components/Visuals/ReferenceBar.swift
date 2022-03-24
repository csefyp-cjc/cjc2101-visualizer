//
//  ReferenceBar.swift
//  visualizer
//
//  Created by Andrew Li on 22/3/2022.
//

import SwiftUI

struct ReferenceBar: View {
    let val: Double // val that it represents ( for height calculation )
    let width: Int
    let color: Color
    let showValue: Bool
    var peakFrequency: Float = 0.0
    
    func format(_ peakFrequency: Float) -> String {
        if (peakFrequency < 0.0) {
            return ""
        } else {
            return String(format: "%.0fHz", peakFrequency)
        }
    }
    
    private func barHeight(_ val: Double) -> CGFloat {
       return CGFloat(val * 50 >= 16 ? 16 : val * 50)
    }
    
    var body: some View {
        VStack {
            VStack {
                if (val > 0) {
                    Rectangle()
                        .fill(color)
                        .frame(width: CGFloat(width), height: barHeight(val))
                        .cornerRadius(4)
                        .animation(.easeOut(duration: 0.15))
                }
            }
            .frame(width: CGFloat(width), height: CGFloat(50 * val), alignment: .top)
            .frame(maxHeight: 450, alignment: .bottom)
        }
        .overlay(
            Text(format(peakFrequency))
                .foregroundColor(.accent.highlight)
                .font(.label.medium)
                .frame(width: 65)
                .offset(x: -6, y: -CGFloat(50 * val) - 2)
                .if(!showValue){$0.hidden()}
            , alignment: .bottomLeading
        )
        
    }
}

struct ReferenceBar_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceBar(val: 20, width: 4, color: .accent.success, showValue: true)
            .previewLayout(.sizeThatFits)
    }
}
