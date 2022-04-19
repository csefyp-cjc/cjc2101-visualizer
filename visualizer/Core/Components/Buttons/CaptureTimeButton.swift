//
//  CaptureTimeButton.swift
//  visualizer
//
//  Created by Mark Cheng on 16/4/2022.
//

import SwiftUI

struct CaptureTimeButton: View {
    let action: () -> Void
    let captureTime: Int

    var body: some View {
        Button {
            self.action()
        } label: {
            Text("\(captureTime) s")
                .font(.label.medium)
                .foregroundColor(.neutral.onSurface)
                .padding(EdgeInsets(top: 8, leading: 36, bottom: 8, trailing: 36))
                .background(Color.neutral.surface)
                .cornerRadius(16)
        }
    }
}

struct CaptureTimeButton_Previews: PreviewProvider {
    static func test() -> Void {
        print("Drawer Button Clicked")
    }

    static var previews: some View {
        CaptureTimeButton(action: self.test, captureTime: 2)
    }
}
