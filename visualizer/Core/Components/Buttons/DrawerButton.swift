import SwiftUI

struct DrawerButton: View {
    let action: () -> Void
    
    var body: some View{
        Button{
            self.action()
        }label:{
            Image(systemName: "tray.fill")
                .frame(width: 48, height: 48)
                .foregroundColor(.neutral.onSurface)
                .background(Color.neutral.surface)
                .clipShape(Circle())
                .font(.system(size: 22))
        }
    }
}

struct DrawerBtn_Previews: PreviewProvider {
    static func test() -> Void {
        print("More Button Clicked")
    }
    
    static var previews: some View {
        DrawerButton(action: self.test)
            .previewLayout(.fixed(width: 38, height: 38))
    }
}
