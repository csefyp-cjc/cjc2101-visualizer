//
//  SettingSheet.swift
//  visualizer
//
//  Created by Andrew Li on 25/11/2021.
//

import SwiftUI 

struct SettingSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var audioViewModel: AudioViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Spacer()
                
                Text("Setting")
                    .font(.heading.small)
                
                Spacer()
                
                DismissButton(action: {presentationMode.wrappedValue.dismiss()})
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
                .frame(height: 32)
            
            Group {
                
                Text("Note Representation")
                    .font(.label.medium)
                    .foregroundColor(.foundation.primary)
                
                HStack(spacing: 12){
                        SettingButton(label: "♭", type: "noteRepresentation")
                        
                        SettingButton(label: "♯", type: "noteRepresentation")
                    }
                    
                    Spacer()
                        .frame(height: 24)
                }
                
                Group {
                    Text("Level of noise")
                        .font(.label.medium)
                    
                    HStack(spacing: 12){
                        SettingButton(label: "Low", type: "noiseLevel")
                        
                        SettingButton(label: "Medium", type: "noiseLevel")
                        
                        SettingButton(label: "High", type: "noiseLevel")
                    }
                    
                    Text(audioViewModel.settings.noiseLevel.getDescription())
                        .font(.label.xsmall)
                        .foregroundColor(.foundation.secondary)
                    
                    Spacer()
                        .frame(height: 24)
                }
                
                Group {
                    Text("Level of accuracy")
                        .font(.label.medium)
                    
                    HStack(spacing: 12){
                        SettingButton(label: "Tuning", type: "accuracyLevel")
                        
                        SettingButton(label: "Practice", type: "accuracyLevel")
                        
                    }
                    
                    Text(audioViewModel.settings.accuracyLevel.getDescription())
                        .font(.label.xsmall)
                        .foregroundColor(.foundation.secondary)
                    
                    Spacer()
                        .frame(height: 24)
                    
                }
                
                Group {
                    Text("Tips")
                        .font(.label.medium)
                    
                    HStack(spacing: 10) {
                        Text("💡")
                        
                        Text("New to scentific music? ")
                            .font(.label.small)
                            .foregroundColor(.foundation.primary)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color.background.bgSecondary)
                    .cornerRadius(8)
                }
                
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24))
            .foregroundColor(.background.onBgPrimary)
        }
    }
    
    struct SettingSheet_Previews: PreviewProvider {
        static var previews: some View {
            SettingSheet()
                .environmentObject(AudioViewModel())
        }
    }