import SwiftUI

struct PitchView: View {
    @EnvironmentObject var audioViewModel: AudioViewModel
    @State private var touching: Bool = false
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                HelpButton()
                    .padding(15)
                Spacer()
                LiveButton(action:audioViewModel.toggle)
                    .padding(15)
            }.frame(maxWidth: .infinity, alignment: .trailing)
            
            PitchLetter(pitchNotation: audioViewModel.pitchNotation, pitchFrequency: audioViewModel.pitchFrequency)
            
            if(!touching){
                PitchIndicator(position: 1).transition(.opacity)
            }
            
            Spacer()
            
            Frequencies(amplitudes: audioViewModel.amplitudes).frame(
                minWidth: 0,
                maxWidth: .infinity
            ).modifier(TouchEventModifier(changeState: {
                //TODO: simplify the usage of this modifier
                (touchState) in
                if(touchState == .down){
                    withAnimation(.easeOut(duration: 0.1)){
                        self.touching = true
                    }
                }else{
                    withAnimation(.easeOut(duration: 0.1)){
                        self.touching = false
                    }
                }
            }))
                .scaleEffect(touching ? 0.85 : 1, anchor: UnitPoint(x: 0, y: 0))
                .overlay(Axis().if(!touching){$0.hidden()})
        }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
    }
}

struct PitchView_Previews: PreviewProvider {
    static var previews: some View {
        PitchView().environmentObject(AudioViewModel())
    }
}
