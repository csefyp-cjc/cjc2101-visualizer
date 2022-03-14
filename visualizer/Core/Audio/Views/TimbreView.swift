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
    
    @AppStorage(InteractiveTutorial.Page.timbre.rawValue) var firstLaunch: Bool?
    
    @State private var showSheet: Bool = false
    @State private var showTutorial: Bool = false
    @State private var showDrawer: Bool = false
    
    @Binding var isShowingModal: Bool
    
    var body: some View {
        ZStack {
            Color.neutral.background
                .ignoresSafeArea(.all)
            
            ZStack(alignment: .top) {
                VStack {
                    PitchLetter(pitchNotation: $vm.audio.pitchNotation,
                                noteRepresentation: vm.settingVM.settings.noteRepresentation,
                                changeNoteRepresentationSetting: vm.settingVM.changeNoteRepresentationSetting
                    )
                }
                .padding(.top, 72)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
                
                VStack {
                    HStack(alignment: .top) {
                        MoreButton(action: {showSheet.toggle()})
                            .padding(15)
                        
                        Spacer()
                        
                        DrawerButton(action: {
                            showDrawer.toggle()
                            isShowingModal.toggle()
                        })
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
                
                VStack {
                    Spacer()
                    ZStack {
                        Harmonics(harmonics: vm.audio.harmonicAmplitudes,
                                  isReference: false
                        )
                        
                        Harmonics(harmonics: vm.referenceHarmonicAmplitudes,
                                  isReference: true
                        )
                    }
                }
            }
            
            ZStack {
                if (showTutorial) {
                    InteractiveTutorialView(showTutorial: $showTutorial,
                                            page: InteractiveTutorial.Page.timbre)
                        .animation(.default)
                }
            }
            .transition(.opacity.animation(.easeIn(duration: 0.3)))
            .animation(.default)
            .onAppear {
                guard let _ = firstLaunch else {
                    showTutorial.toggle()
                    firstLaunch = false
                    return
                }
            }
            
            ZStack {
                TimbreDrawerView(isShowing: $showDrawer,
                                 isShowingModal: $isShowingModal
                ).environmentObject(vm.timbreDrawerVM)
            }
        }
    }
}

struct TimbreView_Previews: PreviewProvider {
    @State static var isShowingModal: Bool = false
    static var previews: some View {
        TimbreView(isShowingModal: $isShowingModal)
            .environmentObject(AudioViewModel())
            .environmentObject(WatchConnectivityViewModel())
    }
}
