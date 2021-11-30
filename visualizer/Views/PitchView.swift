import SwiftUI

struct PitchView: View {
    @EnvironmentObject var audioViewModel: AudioViewModel
    @State private var touching: Bool = false
    @State private var showSheet: Bool = false
    
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
            
            VStack{
                HStack(alignment: .top){
                    MoreButton(action: {showSheet.toggle()})
                        .padding(15)
                    Spacer()
                    LiveButton(action:audioViewModel.toggle)
                        .padding(15)
                }.frame(maxWidth: .infinity, alignment: .trailing)
                
                PitchLetter(pitchNotation: audioViewModel.pitchNotation, pitchFrequency: audioViewModel.pitchFrequency)
                
                if(!touching){
                    PitchIndicator(pitchDetune: audioViewModel.pitchDetune, position: position, accuracyLevel: audioViewModel.settings.accuracyLevel)
                        .transition(.opacity)
                }
                
                Spacer()
                
                Frequencies(amplitudes: audioViewModel.amplitudes, peakBarIndex: audioViewModel.peakBarIndex,
                            match: position == 4
                ).frame(
                    minWidth: 0,
                    maxWidth: .infinity
                )
    //            .onTouch{ touchState in
    //                if(touchState == .down){
    //                    withAnimation(.easeOut(duration: 0.1)){
    //                        self.touching = true
    //                    }
    //                }else{
    //                    withAnimation(.easeOut(duration: 0.1)){
    //                        self.touching = false
    //                    }
    //                }
    //            }
    //            .scaleEffect(touching ? 0.85 : 1, anchor: UnitPoint(x: 0, y: 0))
    //            .overlay(Axis().if(!touching){$0.hidden()})
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $showSheet, content: {
                SettingSheet()
        })
        }
    }
}


struct PitchView_Previews: PreviewProvider {
    static var previews: some View {
        PitchView().environmentObject(AudioViewModel()).previewDevice("iPhone 11")
    }
}
