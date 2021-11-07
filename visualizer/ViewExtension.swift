// Ref: https://stackoverflow.com/questions/57467353/conditional-property-in-swiftui
// TODO: change to an modifier maybe

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}
