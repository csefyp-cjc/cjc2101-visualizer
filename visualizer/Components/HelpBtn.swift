import SwiftUI

struct HelpBtn: View {
    
    
    var body: some View{
        Button{
            
        }label:{
            Image(systemName: "questionmark").frame(width: 38, height: 38).foregroundColor(.white).background(Color("primary")).clipShape(Circle()).font(.system(size: 21))
        }
    }
}

struct HelpBtn_Previews: PreviewProvider {
    static var previews: some View {
        HelpBtn().previewLayout(.fixed(width: 38, height: 38))
    }
}
