import SwiftUI

struct DrawerBtn: View {
    
    
    var body: some View{
        Button{
            
        }label:{
            Image(systemName: "square.stack.3d.down.right.fill").frame(width: 38, height: 38).foregroundColor(.white).background(Color("primary")).clipShape(Circle()).font(.system(size: 23))
        }
    }
}

struct DrawerBtn_Previews: PreviewProvider {
    static var previews: some View {
        DrawerBtn().previewLayout(.fixed(width: 38, height: 38))
    }
}
