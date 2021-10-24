import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var audio: AudioModel
    @State var data = [CGFloat](repeating: CGFloat(0.5), count: 64)
    
    var body: some View {
        VStack{
            Button(action: {
                self.audio.start()
            }){
                Text("START")
            }
            Frequency_view(amplitudes: $audio.timeDomainBuffer)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AudioModel())
    }
}
