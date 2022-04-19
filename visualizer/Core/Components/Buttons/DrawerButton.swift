import SwiftUI

struct DrawerButton: View {
    let action: () -> Void
    let selectedInstrument: TimbreDrawer.InstrumentTypes
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(uiImage: UIImage(named: selectedInstrument.icon)!)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22)
                .foregroundColor(.neutral.onSurface)
        }
        .frame(width: 48, height: 48)
        .background(Color.neutral.surface)
        .clipShape(Circle())
    }
}

struct DrawerBtn_Previews: PreviewProvider {
    static func test() -> Void {
        print("Drawer Button Clicked")
    }
    
    static var previews: some View {
        DrawerButton(action: self.test,
                     selectedInstrument: TimbreDrawer.InstrumentTypes.piano)
            .previewLayout(.fixed(width: 38, height: 38))
    }
}
