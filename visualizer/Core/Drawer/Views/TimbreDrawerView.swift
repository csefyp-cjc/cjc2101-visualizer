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
    @Binding var isShowingModal: Bool
    
    func choose(instrument: TimbreDrawer.InstrumentTypes) -> Void {
        vm.timbreDrawer.selected = instrument
    }
    
    var body: some View {
        DrawerView(isShowing: $isShowing, isShowingModal: $isShowingModal){
            VStack(alignment: .leading) {
                Text("Instruments")
                    .font(.heading.small)
                
                VStack(alignment: .leading){
                    HStack {
                        InstrumentButton(action: self.choose, type: TimbreDrawer.InstrumentTypes.piano, selected: vm.isSelected(TimbreDrawer.InstrumentTypes.piano))
                        
                        Spacer()
                        
                        InstrumentButton(action: self.choose, type:TimbreDrawer.InstrumentTypes.violin,selected: vm.isSelected(TimbreDrawer.InstrumentTypes.violin))
                        
                        Spacer()
                        
                        InstrumentButton(action: self.choose, type: TimbreDrawer.InstrumentTypes.cello,selected: vm.isSelected(TimbreDrawer.InstrumentTypes.cello))
                    }
                    
                    Spacer()
                        .frame(height: 24)
                    
                    HStack {
                        InstrumentButton(action: self.choose, type: TimbreDrawer.InstrumentTypes.flute,selected: vm.isSelected(TimbreDrawer.InstrumentTypes.flute))
                    }
                }
                .padding()
            }
            .padding(EdgeInsets(top: 40, leading: 32, bottom: 40, trailing: 32))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            // For dragging gesture
            .background(Color.neutral.background.opacity(0.00001))
            
            
        }
    }
    
  
}

struct TimbreDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        TimbreDrawerView(isShowing: .constant(true),
                         isShowingModal: .constant(true)
        ).environmentObject(TimbreDrawerViewModel())
    }
}
