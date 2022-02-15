//
//  TimbreDrawer.swift
//  visualizer
//
//  Created by Mark Cheng on 14/2/2022.
//

import SwiftUI

struct TimbreDrawerView: View {
    @EnvironmentObject var vm: TimbreDrawerViewModel
    @Binding var isShowing: Bool
    
    func choose(instrument: TimbreDrawer.InstrumentTypes) -> Void {
        vm.timbreDrawer.selected = instrument
    }
    
    var body: some View {
        DrawerView(isShowing: $isShowing){
            VStack(alignment: .leading){
                Text("Instruments")
                    .font(.heading.small)
                VStack(alignment: .leading){
                    HStack{
                        InstrumentButton(action: self.choose, type: TimbreDrawer.InstrumentTypes.piano, selected: vm.isSelected(TimbreDrawer.InstrumentTypes.piano))
                        Spacer()
                        InstrumentButton(action: self.choose, type:TimbreDrawer.InstrumentTypes.violin,selected: vm.isSelected(TimbreDrawer.InstrumentTypes.violin))
                        Spacer()
                        InstrumentButton(action: self.choose, type: TimbreDrawer.InstrumentTypes.cello,selected: vm.isSelected(TimbreDrawer.InstrumentTypes.cello))
                    }
                    HStack{
                        InstrumentButton(action: self.choose, type: TimbreDrawer.InstrumentTypes.guitar,selected: vm.isSelected(TimbreDrawer.InstrumentTypes.guitar))
                    }
                }.padding()
            }
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24))
        }
    }
}

struct TimbreDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        TimbreDrawerView(isShowing: .constant(true)).environmentObject(TimbreDrawerViewModel())
    }
}
