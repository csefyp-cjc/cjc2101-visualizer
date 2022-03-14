import SwiftUI

struct PitchView: View {
    @EnvironmentObject var vm: AudioViewModel
    @EnvironmentObject var watchConnectVM: WatchConnectivityViewModel
    
    @AppStorage(InteractiveTutorial.Page.pitch.rawValue) var firstLaunch: Bool?
    
    @State private var touching: Bool = false
    @State private var showSheet: Bool = false
    @State private var showTutorial: Bool = false
    
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
                    
                    if (!touching) {
                        PitchIndicator(pitchDetune: vm.audio.pitchDetune,
                                       position: vm.getPitchIndicatorPosition(),
                                       isPitchAccurate: vm.audio.isPitchAccurate
                        )
                            .transition(.opacity)
                    }
                    
                    Spacer()
                    
                    Frequencies(amplitudes: vm.audio.amplitudesToDisplay,
                                noteRepresentation: vm.settings.noteRepresentation,
                                peakBarIndex: vm.audio.peakBarIndex,
                                isPitchAccurate: vm.audio.isPitchAccurate,
                                peakFrequency: vm.audio.pitchFrequency
                                
                    )
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding(.top, 72)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
                .sheet(isPresented: $showSheet, content: {
                    SettingView(showTutorial: $showTutorial)
                        .environmentObject(vm.settingVM)
                })
                
                HStack(alignment: .top) {
                    MoreButton(action: {showSheet.toggle()})
                        .padding(15)
                    
                    Spacer()
                    
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
            
            ZStack {
                if (showTutorial) {
                    InteractiveTutorialView(showTutorial: $showTutorial,
                                            page: InteractiveTutorial.Page.pitch)
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
        }
    }
}


struct PitchView_Previews: PreviewProvider {
    static var previews: some View {
        PitchView()
            .environmentObject(AudioViewModel())
            .environmentObject(WatchConnectivityViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone-XR"))
        
        PitchView()
            .environmentObject(AudioViewModel())
            .environmentObject(WatchConnectivityViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone-13-Pro"))
    }
}
