//
//  TimbreTag.swift
//  visualizer
//
//  Created by Andrew Li on 23/3/2022.
//

import SwiftUI

struct TimbreTag: View {
    var text: String
    var value: Double
    
    let indicatorWidth = 110
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.label.small)
                .fontWeight(.semibold)
                .foregroundColor(.neutral.onSurface)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.neutral.onSurface)
                    .cornerRadius(15)
                    .opacity(0.15)
                
                Rectangle()
                    .fill(Color.neutral.onSurface)
                    .cornerRadius(15)
                    .frame(width: 5)
                    .offset(x: CGFloat(indicatorWidth - 16 - 16) * value - (5 / 2))
                    .animation(.spring(), value: value)
            }
            .frame(width: .infinity, height: 8)
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        .background(Color.neutral.surface)
        .frame(maxWidth: CGFloat(indicatorWidth))
        .cornerRadius(20)
    }
}

struct TimbreTag_Previews: PreviewProvider {
    static var previews: some View {
        TimbreTag(text: "Brightness", value: 0.5)
    }
}
