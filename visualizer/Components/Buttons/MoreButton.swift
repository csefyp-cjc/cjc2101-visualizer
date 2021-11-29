//
//  MoreButton.swift
//  visualizer
//
//  Created by Andrew Li on 25/11/2021.
//

import SwiftUI

struct MoreButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: "ellipsis")
                .frame(width: 38, height: 38)
                .foregroundColor(.foundation.onPrimary)
                .background(Color.foundation.primary)
                .clipShape(Circle())
                .font(.system(size: 18))
        }
    }
}

struct MoreButton_Previews: PreviewProvider {
    static var previews: some View {
        MoreButton(action: self.test)
    }
    
    static func test() -> Void {
        print("More Button Clicked")
    }
}
