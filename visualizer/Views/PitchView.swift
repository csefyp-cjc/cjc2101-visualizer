import SwiftUI

struct PitchView: View {
    @State private var touching: Bool = false
    var amplitudes: [Double]
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                HelpButton()
                    .padding(15)
                Spacer()
                LiveButton()
                    .padding(15)
            }.frame(maxWidth: .infinity, alignment: .trailing)
            PitchLetter()
            if(!touching){
                PitchIndicator(position: 1).transition(.opacity)
            }
            Spacer()
            Frequencies(amplitudes: amplitudes).frame(
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
        PitchView(amplitudes: Array(repeating: 0.2, count: 50))
    }
}
