//
//  TimbreView.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct TimbreView: View {
    var body: some View {
        ZStack {
            Color.neutral.background
                .ignoresSafeArea(.all)
            
            Text("Timbre")
        }
    }
}

struct TimbreView_Previews: PreviewProvider {
    static var previews: some View {
        TimbreView().environmentObject(AudioViewModel())
    }
}
