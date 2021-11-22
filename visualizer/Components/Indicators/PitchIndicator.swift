import SwiftUI

struct PitchIndicator: View {
    var pitchDetune: Float
    
    var position: Int {
        switch pitchDetune {
        case let cent where cent < 0:
            return 4 - Int(abs(pitchDetune) / 12.5)
        case let cent where cent > 0:
            return Int(pitchDetune / 12.5) + 4
        case let cent where cent == 0:
            return 4
        default:
            return 4
        }
    }  // range: 0-8
    
    var body: some View {
        Rectangle()
            .fill(position == 4 ? Color.background.bgSuccess : Color.background.bgSecondary)
            .frame(maxWidth: 328, maxHeight: 55)
            .cornerRadius(15)
            .overlay(
                HStack{
                    ForEach(0...3, id: \.self) { i in
                        if(i == position){
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.accent.error)
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
                                .foregroundColor(.accent.error)
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
        PitchIndicator(pitchDetune: 0.0)
    }
}
