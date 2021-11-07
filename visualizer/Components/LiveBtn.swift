import SwiftUI

struct LiveBtn: View {
    
    
    var body: some View{
        Button{
            
        }label:{
            Image(systemName: "waveform").frame(width: 38, height: 38).foregroundColor(.white).background(Color("primary")).clipShape(Circle()).font(.system(size: 22))
        }
    }
}

struct LiveBtn_Previews: PreviewProvider {
    static var previews: some View {
        LiveBtn().previewLayout(.fixed(width: 38, height: 38))
    }
}
