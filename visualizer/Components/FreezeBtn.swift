//
//  FreezeBtn.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct FreezeBtn: View {
    
    
    var body: some View{
        Button{
            
        }label:{
            Image(systemName: "waveform").frame(width: 38, height: 38).foregroundColor(.white).background(Color.foundation["primary"]).clipShape(Circle()).font(.system(size: 22))
        }
    }
}

struct FreezeBtn_Previews: PreviewProvider {
    static var previews: some View {
        FreezeBtn().previewLayout(.fixed(width: 38, height: 38))
    }
}
