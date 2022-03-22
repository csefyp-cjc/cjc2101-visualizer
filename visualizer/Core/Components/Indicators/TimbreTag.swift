//
//  TimbreTag.swift
//  visualizer
//
//  Created by Andrew Li on 23/3/2022.
//

import SwiftUI

struct TimbreTag: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.label.small)
            .fontWeight(.semibold)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .foregroundColor(.neutral.onSurface)
            .background(Color.neutral.surface)
            .cornerRadius(40)
    }
}

struct TimbreTag_Previews: PreviewProvider {
    static var previews: some View {
        TimbreTag(text: "Bright")
    }
}
