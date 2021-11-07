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
            Text(pitch).font(.system(size: 64, weight:.heavy)).foregroundColor(Color("primary"))
            Text("261hz").font(.system(size: 18)).foregroundColor(Color("primary"))
        }
    }
}

struct PitchIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PitchIndicator()
    }
}
