import SwiftUI

struct HelpButton: View {
    
    
    var body: some View{
        Button{
            
        }label:{
            Image(systemName: "questionmark")
                .frame(width: 48, height: 48)
                .foregroundColor(.neutral.onSurface)
                .background(Color.neutral.surface)
                .clipShape(Circle())
                .font(.system(size: 22))
        }
    }
}

struct HelpBtn_Previews: PreviewProvider {
    static var previews: some View {
        HelpButton().previewLayout(.fixed(width: 38, height: 38))
    }
}
