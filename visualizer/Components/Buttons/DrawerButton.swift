import SwiftUI

struct DrawerButton: View {
    
    
    var body: some View{
        Button{
            
        }label:{
            Image(systemName: "square.stack.3d.down.right.fill")
                .frame(width: 38, height: 38)
                .foregroundColor(.neutral.onSurface)
                .background(Color.neutral.surface)
                .clipShape(Circle())
                .font(.system(size: 18))
        }
    }
}

struct DrawerBtn_Previews: PreviewProvider {
    static var previews: some View {
        DrawerButton().previewLayout(.fixed(width: 38, height: 38))
    }
}
