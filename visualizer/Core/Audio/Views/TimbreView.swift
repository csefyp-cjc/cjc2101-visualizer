//
//  TimbreView.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct TimbreView: View {
    @State private var showSheet: Bool = false
    @State private var showTutorial: Bool = false
    
    var body: some View {
        ZStack {
            Color.neutral.background
                .ignoresSafeArea(.all)
            
            VStack {
                HStack(alignment: .top){
                    MoreButton(action: {showSheet.toggle()})
                        .padding(15)
                    
                    Spacer()                                        
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("Timbre")
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $showSheet, content: {
                SettingView(showTutorial: $showTutorial)
            })
        }
    }
}

struct TimbreView_Previews: PreviewProvider {
    static var previews: some View {
        TimbreView()
    }
}
