import SwiftUI

struct PitchIndicator: View {
    var pitchDetune: Float
    
    var position: Int
    
    var isPitchAccurate: Bool
    
    var body: some View {
        Rectangle()
            .fill(isPitchAccurate ? Color.accent.successContainer : Color.neutral.surface)
            .frame(maxWidth: 328, maxHeight: 55)
            .cornerRadius(15)
            .overlay(
                HStack{
                    ForEach(0...3, id: \.self) { i in
                        if(i == position){
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(isPitchAccurate ? .accent.success : .accent.error)
                                .padding(5)
                        }else{
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundColor(.foundation.secondary)
                                .padding(10)
                        }
                    }
                    if(position == 4){
                        Circle().frame(width: 14, height: 14)
                            .foregroundColor(.accent.success)
                            .padding(10)
                    }else{
                        Circle().frame(width: 14, height: 14)
                            .foregroundColor(.foundation.primary)
                            .padding(10)
                    }
                    ForEach(5...8, id: \.self) { j in
                        if(j == position){
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(isPitchAccurate ? .accent.success : .accent.error)
                                .padding(5)
                        }else{
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundColor(.foundation.secondary)
                                .padding(10)
                        }
                    }
                }.transition(.scale)
                    .animation(.easeInOut)
            )
    }
}

struct PitchMetre_Previews: PreviewProvider {
    static var previews: some View {
        PitchIndicator(pitchDetune: 0.0, position: 4, isPitchAccurate: true).previewDevice("iPhone 11")
        
        PitchIndicator(pitchDetune: 10.0, position: 2, isPitchAccurate: false).previewDevice("iPhone 11")
    }
}
