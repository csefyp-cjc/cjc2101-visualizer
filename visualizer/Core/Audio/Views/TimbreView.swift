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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @AppStorage(InteractiveTutorial.Page.timbre.rawValue) var firstLaunch: Bool?
    
    @State private var showSheet: Bool = false
    @State private var showTutorial: Bool = false
    @State private var showDrawer: Bool = false
    @State private var displayMode: DisplayMode = .yours
    
    @Binding var isShowingModal: Bool
    
    private var isCompact: Bool { horizontalSizeClass == .compact}
    
    enum DisplayMode: CaseIterable, Identifiable {
        case yours
        case suggested
        case mixed
        
        var id: String { title }
        
        var title: String {
            switch self {
            case .yours:
                return "Yours"
            case .suggested:
                return "Suggested"
            case .mixed:
                return "Mixed"
            }
        }
    }
    
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
                    
                    Spacer()
                        .frame(height: isCompact ? 52 : 0)
                    
                    HStack(alignment: .center, spacing: 4) {
                        TimbreTag(text: "Bright")
                        
                        TimbreTag(text: "Inharmonic")
                        
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 12)
                    
                    Picker("Display Mode", selection: $displayMode) {
                        Text(DisplayMode.yours.title)
                            .tag(DisplayMode.yours)
                        Text(DisplayMode.suggested.title)
                            .tag(DisplayMode.suggested)
                        Text(DisplayMode.mixed.title)
                            .tag(DisplayMode.mixed)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 20)
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
                        switch displayMode {
                        case .yours:
                            Harmonics(harmonics: vm.audio.harmonicAmplitudes,
                                      isReference: false,
                                      isMixed: false
                            )
                        case .suggested:
                            Harmonics(harmonics: vm.referenceHarmonicAmplitudes,
                                      isReference: true,
                                      isMixed: false
                            )
                        case .mixed:
                            Harmonics(harmonics: vm.audio.harmonicAmplitudes,
                                      isReference: false,
                                      isMixed: false
                            )
                            
                            Harmonics(harmonics: vm.referenceHarmonicAmplitudes,
                                      isReference: true,
                                      isMixed: true
                            )
                        }
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
