//
//  TimbreTag.swift
//  visualizer
//
//  Created by Andrew Li on 23/3/2022.
//

import SwiftUI

struct TimbreTag: View {
    var audioFeature: AudioFeature
    @Binding var value: Double
    var toggleAudioFeaturesDrawer: (AudioFeature, Binding<Double>) -> Void
    
    let width = 130
    
    var body: some View {
        Button {
            toggleAudioFeaturesDrawer(audioFeature, $value)
        } label: {
            VStack(spacing: 8) {
                Text(audioFeature.rawValue)
                    .font(.label.small)
                    .fontWeight(.semibold)
                    .foregroundColor(.neutral.onSurface)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.neutral.onSurface)
                        .cornerRadius(15)
                        .opacity(0.15)
                    
                    Rectangle()
                        .fill(Color.neutral.onSurface)
                        .cornerRadius(15)
                        .frame(width: 5)
                        .offset(x: CGFloat(width - 16 - 16) * value - (5 / 2))
                        .animation(.spring(), value: value)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 8)
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .background(Color.neutral.surface)
            .frame(maxWidth: CGFloat(width))
            .cornerRadius(20)
        }
    }
}

struct TimbreTag_Previews: PreviewProvider {
    static var previews: some View {
        TimbreTag(audioFeature: AudioFeature.spectralCentroid,
                  value: .constant(0.5),
                  toggleAudioFeaturesDrawer: {(_ audioFeature: AudioFeature, _ value: Binding<Double>) -> Void in return })
    }
}
