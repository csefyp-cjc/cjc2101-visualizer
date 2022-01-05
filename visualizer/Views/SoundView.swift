//
//  SoundView.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct SoundView: View {
    @EnvironmentObject var audioViewModel: AudioViewModel
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.neutral.background
                .ignoresSafeArea(.all)
            
            VStack{
                HStack(alignment: .top){
                    MoreButton(action: {showSheet.toggle()})
                        .padding(15)
                    
                    Spacer()
                    
                    DrawerButton()
                        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 5))
                    
                    LiveButton(action: audioViewModel.toggle)
                        .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 15))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .sheet(isPresented: $showSheet, content: {
                SettingSheet()
            })
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        }
        
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SoundView()
            .environmentObject(AudioViewModel())
    }
}
