import SwiftUI

struct LiveButton: View {
    let action: ()->Void
    
    var body: some View{
        Button{
            self.action()
        }label:{
            Image(systemName: "waveform").frame(width: 38, height: 38)
                .foregroundColor(.foundation.onPrimary)
                .background(Color.foundation.primary)
                .clipShape(Circle())
                .font(.system(size: 18))
        }
    }
}

struct LiveBtn_Previews: PreviewProvider {
    static var previews: some View {
        LiveButton(action: AudioViewModel().toggle).previewLayout(.fixed(width: 38, height: 38))
    }
}
