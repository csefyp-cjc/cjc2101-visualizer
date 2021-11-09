//
//  PitchIndicator.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct PitchIndicator: View {
    @State private var pitch = "C"
    
    
    var body: some View {
        VStack{
            Text(pitch)
                .font(.system(size: 64, weight:.heavy))
                .foregroundColor(.foundation.primary)
            Text("261hz")
                .font(.label.large)
                .foregroundColor(.foundation.primary)
        }
    }
}

struct PitchIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PitchIndicator()
    }
}
