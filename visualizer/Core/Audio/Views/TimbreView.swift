//
//  TimbreView.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct TimbreView: View {
    @EnvironmentObject var vm: AudioViewModel
    @EnvironmentObject var watchConnectVM: WatchConnectivityViewModel
    @State private var showSheet: Bool = false
    @State private var showTutorial: Bool = false
    @State private var showDrawer: Bool = false
    
    var body: some View {
        ZStack {
            Color.neutral.background
                .ignoresSafeArea(.all)
            ZStack(alignment: .top) {
                VStack {
                    HStack(alignment: .top){
                        MoreButton(action: {showSheet.toggle()})
                            .padding(15)
                        
                        Spacer()
                        
                        DrawerButton(action: {showDrawer.toggle()})
                            .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                        
                        LiveDropdown(isPitchAccurate: $vm.audio.isPitchAccurate,
                                     isWatchLive: $watchConnectVM.isWatchLive,
                                     start: vm.start,
                                     stop: vm.stop,
                                     options: [3,5,10],
                                     toggleWatchLive: watchConnectVM.toggleWatchLive
                        )
                            .padding(15)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
                .sheet(isPresented: $showSheet, content: {
                    SettingView(showTutorial: $showTutorial)
                        .environmentObject(vm.settingVM)
                })
                
                VStack{
                    Spacer()
                    Harmonics(harmonics: vm.audio.harmonicAmplitudes)
                }
            }
        }
    }
}

struct TimbreView_Previews: PreviewProvider {
    static var previews: some View {
        TimbreView()
            .environmentObject(AudioViewModel())
            .environmentObject(WatchConnectivityViewModel())
    }
}
