//
//  AudioFeaturesDrawerView.swift
//  visualizer
//
//  Created by Andrew Li on 30/3/2022.
//

import SwiftUI

struct AudioFeaturesDrawerView: View {
    @EnvironmentObject var vm: AudioFeaturesDrawerViewModel
    @Binding var isShowing: Bool
    @Binding var isShowingModal: Bool
    @Binding var selectedFeature: AudioFeature
    @Binding var value: Double
    
    var body: some View {
        DrawerView(isShowing: $isShowing, isShowingModal: $isShowingModal) {
            VStack(alignment: .leading) {
                Text(selectedFeature.rawValue)
                    .font(.heading.small)
                    // Weird alignment behaviour, Workaround only
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 16)
                
                Text(selectedFeature.getDescription())
                    .font(.text.paragraph)
                
                Spacer()
                    .frame(height: 32)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.neutral.onSurface)
                        .cornerRadius(15)
                        .opacity(0.15)
                    
                    Rectangle()
                        .fill(Color.neutral.onSurface)
                        .cornerRadius(15)
                        .frame(width: 7)
                        .offset(x: CGFloat(UIScreen.main.bounds.width - 32 - 32) * value - (7 / 2))
                        .animation(.spring(), value: value)
                    
                    Text(String(format: "%.1f", value * 100) + "%")
                        .font(.label.xsmall)
                        .offset(x: CGFloat(UIScreen.main.bounds.width - 32 - 32) * value - (32 / 2),
                                y: CGFloat(-19))
                        .animation(.spring(), value: value)
                }
                .frame(height: 12)
                
                HStack {
                    Text(selectedFeature.getLabels().0)
                        .font(.label.xsmall)
                    
                    Spacer()
                    
                    Text(selectedFeature.getLabels().1)
                        .font(.label.xsmall)
                }
            }
            .padding(EdgeInsets(top: 40, leading: 32, bottom: 40, trailing: 32))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            // For dragging gesture
            .background(Color.neutral.background.opacity(0.00001))
        }
    }
}

struct AudioFeaturesDrawer_Previews: PreviewProvider {
    static var previews: some View {
        AudioFeaturesDrawerView(isShowing: .constant(true),
                                isShowingModal: .constant(true),
                                selectedFeature: .constant(AudioFeature.spectralCentroid),
                                value: .constant(0.0)
        )
        .environmentObject(AudioFeaturesDrawerViewModel())
    }
}
