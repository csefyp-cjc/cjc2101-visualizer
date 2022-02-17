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
    
    var body: some View{
        VStack{
            Button{
                self.action(type)
            }label:{
                Image(systemName: type.icon)
                    .frame(width: 48, height: 48)
                    .foregroundColor(.neutral.onSurface)
                    .background(Color.neutral.surface)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.neutral.surface, lineWidth: 2)
                    )
                    .if(selected){
                        $0.overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    }
//                    .clipShape(Rectangle())
//                    .font(.system(size: 22))
//                    .cornerRadius(15)
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
