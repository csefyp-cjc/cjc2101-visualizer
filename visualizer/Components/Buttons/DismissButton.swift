//
//  DismissButton.swift
//  visualizer
//
//  Created by Andrew Li on 25/11/2021.
//

import SwiftUI

struct DismissButton: View {
    let action: () -> Void
    
    // TODO: Button styling not firm
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: "xmark")
                .frame(width: 32, height: 32)
                .foregroundColor(.neutral.onSurface)
                .background(Color.neutral.surface)
                .clipShape(Circle())
                .font(.system(size: 18))
        }
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton(action: self.test)
    }
    
    static func test() -> Void {
        print("More Button Clicked")
    }
}
