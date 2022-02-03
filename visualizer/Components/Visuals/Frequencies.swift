//
//  Frequencies.swift
//  visualizer
//
//  Created by Mark Cheng on 7/11/2021.
//

import SwiftUI

struct Frequencies: View {
    @GestureState private var isPressed = false
    var amplitudes: [Double]
    var noteRepresentation: Setting.NoteRepresentation
    var peakBarIndex: Int
    var isPitchAccurate: Bool
    var peakFrequency: Float
    let drag = DragGesture(minimumDistance: 0)
    let labels = getLabeling(10)
    
    var body: some View {
        ScrollView(.horizontal){
            ScrollViewReader{ proxy in
                HStack(spacing: 5){
                    ForEach(0...amplitudes.count-1, id: \.self){ i in
                        VStack{
                            if (i == peakBarIndex) {
                                VBar(x: amplitudes[i]*7.0, color: .accent.highlight, showValue: true, peakFrequency: peakFrequency)
                                
                            } else {
                                if(isPitchAccurate){
                                    VBar(x: amplitudes[i]*7.0, color: .accent.successVariant, showValue: false)
                                }else{
                                    VBar(x: amplitudes[i]*7.0, color: .foundation.secondary, showValue: false)
                                }
                            }
                        }
                        .zIndex( i == peakBarIndex ? 1 : 0)
                        .overlay(Text(pitchFromFrequency(Float(i*44100 / 2048), noteRepresentation))
                                    .foregroundColor(.neutral.onAxis)
                                    .font(.label.small)
                                    .frame(width: 40)
                                    .offset(x:0, y:24)
                                    .if(!labels.contains(i)){ $0.hidden() }, alignment: .bottom)
                        
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                .onChange(of: peakBarIndex){ value in
                    withAnimation{
                        proxy.scrollTo(value, anchor: .center)
                    }
                }
            }
        }
    }
}

struct Frequencies_Previews: PreviewProvider {
    static var previews: some View {
        Frequencies(amplitudes: Array(repeating: 0.5, count: 256), noteRepresentation:Setting.default.noteRepresentation, peakBarIndex: -1, isPitchAccurate: true, peakFrequency: 440)
    }
}
