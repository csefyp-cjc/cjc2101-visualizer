//
//  InstrumentButton.swift
//  visualizer
//
//  Created by Mark Cheng on 14/2/2022.
//

import SwiftUI

struct InstrumentButton: View {
    let action: () -> Void
    let type: TimbreDrawer.InstrumentTypes
    
    var body: some View{
        VStack{
            Button{
                self.action()
            }label:{
                Image(systemName: type.icon)
                    .frame(width: 48, height: 48)
                    .foregroundColor(.neutral.onSurface)
                    .background(Color.neutral.surface)
                    .clipShape(Rectangle())
                    .font(.system(size: 22))
                    .cornerRadius(15)
            }
            Text(type.label).font(.label.small)
        }
    }
}

struct InstrumentButton_Previews: PreviewProvider {
    static func test() -> Void {
        print("Instrument Button Clicked")
    }
    
    static var previews: some View {
        InstrumentButton(action: self.test, type: TimbreDrawer.InstrumentTypes.piano)
            .previewLayout(.fixed(width: 48, height: 48))
    }
}
