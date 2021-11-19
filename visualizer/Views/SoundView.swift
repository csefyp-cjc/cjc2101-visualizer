//
//  SoundView.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct SoundView: View {
    var body: some View {
        VStack{
            HStack(alignment: .top){
                HelpButton()
                    .padding(15)
                Spacer()
                DrawerButton()
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 5))
                LiveButton()
                    .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 15))
            }.frame(maxWidth: .infinity, alignment: .trailing)
            
        }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SoundView()
    }
}
