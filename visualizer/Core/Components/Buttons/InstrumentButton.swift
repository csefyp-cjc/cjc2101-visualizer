//
//  InstrumentButton.swift
//  visualizer
//
//  Created by Mark Cheng on 14/2/2022.
//

import SwiftUI

struct InstrumentButton: View {
    let action: (TimbreDrawer.InstrumentTypes) -> Void
    let type: TimbreDrawer.InstrumentTypes
    var selected: Bool
    
    var body: some View {
        VStack {
            Button {
                self.action(type)
            } label: {
                Image(uiImage: UIImage(named: type.icon)!)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(.neutral.onSurface)
            }
            .frame(width: 64, height: 64)
            .background(Color.neutral.surface)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.neutral.surface, lineWidth: 3)
            )
            .if (selected) {
                $0.overlay (
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.foundation.primary, lineWidth: 3)
                )
            }
            Text(type.label).font(.label.small)
        }
    }
}

struct InstrumentButton_Previews: PreviewProvider {
    static func test(type: TimbreDrawer.InstrumentTypes) -> Void {
        print("Instrument Button Clicked")
    }
    
    static var previews: some View {
        InstrumentButton(action: self.test, type: TimbreDrawer.InstrumentTypes.piano, selected: true)
            .previewLayout(.fixed(width: 80, height: 80))
        InstrumentButton(action: self.test, type: TimbreDrawer.InstrumentTypes.piano, selected: false)
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
