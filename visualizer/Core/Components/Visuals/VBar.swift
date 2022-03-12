//
//  VBar.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct VBar: View {
    let val: Double // val that it represents ( for height calculation )
    let width: Int
    let color: Color
    let showValue: Bool
    var peakFrequency: Float = 0.0
    
    func format(_ peakFrequency: Float) -> String{
        if (peakFrequency < 0.0) {
            return ""
        } else {
            return String(format: "%.0fHz", peakFrequency)
        }
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .frame(width: CGFloat(width), height: CGFloat(50 * val))
                .cornerRadius(4)
                .frame(maxHeight: 450, alignment: .bottom)
                .animation(.easeOut(duration: 0.15))
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

struct VBar_Previews: PreviewProvider {
    static var previews: some View {
        VBar(val: 20, width: 4, color: .accent.success, showValue: true).previewLayout(.sizeThatFits)
    }
}
