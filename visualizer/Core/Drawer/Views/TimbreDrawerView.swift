//
//  TimbreDrawer.swift
//  visualizer
//
//  Created by Mark Cheng on 14/2/2022.
//

import SwiftUI

struct TimbreDrawerView: View {
    
    func test() -> Void {
        print("Instrument Button Clicked")
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Instruments")
                .font(.heading.small)
            VStack(alignment: .leading){
                HStack{
                    InstrumentButton(action: self.test, type: TimbreDrawer.InstrumentTypes.piano)
                    Spacer()
                    InstrumentButton(action: self.test, type:TimbreDrawer.InstrumentTypes.violin)
                    Spacer()
                    InstrumentButton(action: self.test, type: TimbreDrawer.InstrumentTypes.cello)
                }
                HStack{
                    InstrumentButton(action: self.test, type: TimbreDrawer.InstrumentTypes.guitar)
                }
            }.padding()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24))
        .foregroundColor(.neutral.onBackground)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct TimbreDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        TimbreDrawerView()
    }
}
