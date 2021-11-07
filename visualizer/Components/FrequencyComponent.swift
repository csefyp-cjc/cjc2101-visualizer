// just for testing/reference

import SwiftUI

struct Frequency_view: View {
//    @Binding var amplitudes: [CGFloat]
    @Binding var amplitudes: [Float]
    @State var foo = false
    
    var body: some View {
        VStack{
            Button(action: {
                foo = !foo
            }){
                Text("Press")
            }
            if(foo) {
                Text("isFoo")
            }
            else {
                Text("notFoo")
            }
        }
        HStack(spacing: 0.0){
            ForEach(0 ..< self.amplitudes.count) { number in
                VBar_view(amplitude: self.$amplitudes[number])
            }
        }
        .background(Color.black)
    }
}

struct AmplitudeVisualizer_Previews: PreviewProvider {
    static var previews: some View {
        Frequency_view(amplitudes: .constant(Array(repeating: 0.5, count: 64)))
    }
}
