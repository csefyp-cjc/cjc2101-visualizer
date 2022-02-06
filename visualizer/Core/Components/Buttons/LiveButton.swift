import SwiftUI

struct LiveButton: View {
    let action: ()->Void
    
    var body: some View{
        Button{
            self.action()
        }label:{
            Image(systemName: "waveform").frame(width: 48, height: 48)
                .foregroundColor(.neutral.onSurface)
                .background(Color.neutral.surface)
                .clipShape(Circle())
                .font(.system(size: 22))
        }
    }
}

struct LiveBtn_Previews: PreviewProvider {
    static var previews: some View {
        LiveButton(action: AudioViewModel().toggle)
            .previewLayout(.fixed(width: 38, height: 38))
    }
}
