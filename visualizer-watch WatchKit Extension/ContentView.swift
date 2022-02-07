//
//  ContentView.swift
//  visualizer-watch WatchKit Extension
//
//  Created by Andrew Li on 7/2/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = WatchConnectivityViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                vm.toggleLive()                
            }) {
                Label("Live", systemImage: "waveform")
                    .font(Font.label.large)
                    .padding()
            }
            .buttonStyle(BorderedButtonStyle(tint: vm.isLive ? .primary : .gray))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
