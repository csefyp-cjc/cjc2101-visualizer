// Ref: https://stackoverflow.com/questions/57467353/conditional-property-in-swiftui

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
    
    @ViewBuilder
    func onTouch(handler: @escaping (TouchState) -> Void)->some View {
        self.modifier(TouchEventModifier(changeState: {touchState in
            handler(touchState)
        }))
    }
}
