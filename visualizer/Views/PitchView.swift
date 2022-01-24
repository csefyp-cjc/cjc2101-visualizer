import SwiftUI

struct PitchView: View {
    @EnvironmentObject var audioViewModel: AudioViewModel
    @State private var touching: Bool = false
    @State private var showSheet: Bool = false
    @State private var showTutorial: Bool = false
    @State private var currentPage: Int = 0
    
    var position: Int {
        switch audioViewModel.pitchDetune {
        case let cent where cent < 0:
            return 4 - Int(abs(audioViewModel.pitchDetune) / 12.5)
        case let cent where cent > 0:
            return Int(audioViewModel.pitchDetune / 12.5) + 4
        case let cent where cent == 0:
            return 4
        default:
            return 4
        }
    }
    
    var body: some View {
        ZStack {
            Color.neutral.background
                .ignoresSafeArea(.all)
            
            ZStack(alignment: .top){
                VStack{
                    PitchLetter(pitchNotation: audioViewModel.pitchNotation, pitchFrequency: audioViewModel.pitchFrequency)
                    
                    if(!touching){
                        PitchIndicator(pitchDetune: audioViewModel.pitchDetune, position: position, accuracyLevel: audioViewModel.settings.accuracyLevel)
                            .transition(.opacity)
                    }
                    
                    Spacer()
                    
                    Frequencies(amplitudes: audioViewModel.amplitudes,
                                noteRepresentation: audioViewModel.settings.noteRepresentation,
                                peakBarIndex: audioViewModel.peakBarIndex,
                                match: position == 4,
                                peakFrequency: audioViewModel.pitchFrequency
                                
                    ).frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                }
                .padding(.top, 72)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
                .sheet(isPresented: $showSheet, content: {
                    SettingSheet(showTutorial: $showTutorial)
                })
                
                HStack(alignment: .top){
                    MoreButton(action: {showSheet.toggle()})
                        .padding(15)
                    
                    Spacer()
                    
//                    LiveButton(action:audioViewModel.toggle)
//                        .padding(15)
                    LiveDropdown(start: audioViewModel.start, stop: audioViewModel.stop, options: [3,5,10]).padding(15)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            if (showTutorial) {
                GeometryReader{ geometry in
                    InteractiveTutorialView(
                        tutorials: [
                            InteractiveTutorial(text: "Pitch and frequencies are correlated. The x-axis here is the letter name of musical notes.",
                                                textPosition: CGSize(width: (geometry.size.width - 32) / 2, height: geometry.size.height - 100),
                                                size: CGSize(width: geometry.size.width - 16, height: 28),
                                                offset: CGSize(width: 0, height: geometry.size.height / 2 - 30)),
                            InteractiveTutorial(text: "The bars indicidates the distribution of the frequencies.",
                                                textPosition: CGSize(width: (geometry.size.width - 32) / 2, height: geometry.size.height / 2),
                                                size: CGSize(width: geometry.size.width, height: 250),
                                                offset: CGSize(width: 0, height: 200))],
                        currentPage: $currentPage,
                        showTutorial: $showTutorial
                    )
                        .animation(.default)
                }
            }
        }
    }
}


struct PitchView_Previews: PreviewProvider {
    static var previews: some View {
        PitchView().environmentObject(AudioViewModel()).previewDevice("iPhone 11")
    }
}
