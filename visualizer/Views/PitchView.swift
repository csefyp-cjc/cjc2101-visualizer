//
//  PitchView.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct PitchView: View {
    var body: some View {
        VStack{
            HStack(alignment: .top){
                FreezeBtn().padding(15)
            }.frame(maxWidth: .infinity, alignment: .trailing)
            PitchIndicator()
            PitchMetre(position: 4)
            Spacer()
            Frequencies().frame(
                minWidth: 0,
                maxWidth: .infinity
            )
        }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
    }
}

struct PitchView_Previews: PreviewProvider {
    static var previews: some View {
        PitchView()
    }
}
