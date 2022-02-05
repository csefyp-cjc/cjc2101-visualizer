//
//  SettingView.swift
//  visualizer
//
//  Created by Andrew Li on 25/11/2021.
//

import SwiftUI 

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: SettingViewModel
    @Binding var showTutorial: Bool
    
    var body: some View {
        ZStack {
            Color.neutral.background
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 8)
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Text("Setting")
                        .font(.heading.small)
                    
                    Spacer()
                        .overlay(
                            DismissButton(action: { presentationMode.wrappedValue.dismiss() }),
                            alignment: .trailing
                        )
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                    .frame(height: 32)
                
                Group {
                    
                    Text("Note Representation")
                        .font(.label.medium)
                        .foregroundColor(.foundation.primary)
                    
                    HStack(spacing: 12){
                        SettingButton(label: "♭",
                                      type: "noteRepresentation",
                                      selected: vm.isSelected(label: "♭", type: "noteRepresentation"),
                                      changeNoteRepresentationSetting: vm.changeNoteRepresentationSetting,
                                      changeNoiseLevelSetting: vm.changeNoiseLevelSetting,
                                      changeAccuracyLevelSetting: vm.changeAccuracyLevelSetting
                        )
                        
                        SettingButton(label: "♯",
                                      type: "noteRepresentation",
                                      selected: vm.isSelected(label: "♯", type: "noteRepresentation"),
                                      changeNoteRepresentationSetting: vm.changeNoteRepresentationSetting,
                                      changeNoiseLevelSetting: vm.changeNoiseLevelSetting,
                                      changeAccuracyLevelSetting: vm.changeAccuracyLevelSetting
                        )
                    }
                    
                    Spacer()
                        .frame(height: 24)
                }
                
                Group {
                    Text("Level of noise")
                        .font(.label.medium)
                    
                    HStack(spacing: 12){
                        SettingButton(label: "Low",
                                      type: "noiseLevel",
                                      selected: vm.isSelected(label: "Low", type: "noiseLevel"),
                                      changeNoteRepresentationSetting: vm.changeNoteRepresentationSetting,
                                      changeNoiseLevelSetting: vm.changeNoiseLevelSetting,
                                      changeAccuracyLevelSetting: vm.changeAccuracyLevelSetting
                        )
                        
                        SettingButton(label: "Medium",
                                      type: "noiseLevel",
                                      selected: vm.isSelected(label: "Medium", type: "noiseLevel"),
                                      changeNoteRepresentationSetting: vm.changeNoteRepresentationSetting,
                                      changeNoiseLevelSetting: vm.changeNoiseLevelSetting,
                                      changeAccuracyLevelSetting: vm.changeAccuracyLevelSetting)
                        
                        SettingButton(label: "High",
                                      type: "noiseLevel",
                                      selected: vm.isSelected(label: "High", type: "noiseLevel"),
                                      changeNoteRepresentationSetting: vm.changeNoteRepresentationSetting,
                                      changeNoiseLevelSetting: vm.changeNoiseLevelSetting,
                                      changeAccuracyLevelSetting: vm.changeAccuracyLevelSetting)
                    }
                    
                    Text(vm.settings.noiseLevel.getDescription())
                        .font(.label.xsmall)
                        .foregroundColor(.neutral.onBackgroundVariant)
                    
                    Spacer()
                        .frame(height: 24)
                }
                
                Group {
                    Text("Level of accuracy")
                        .font(.label.medium)
                    
                    HStack(spacing: 12){
                        SettingButton(label: "Tuning",
                                      type: "accuracyLevel",
                                      selected: vm.isSelected(label: "Tuning", type: "accuracyLevel"),
                                      changeNoteRepresentationSetting: vm.changeNoteRepresentationSetting,
                                      changeNoiseLevelSetting: vm.changeNoiseLevelSetting,
                                      changeAccuracyLevelSetting: vm.changeAccuracyLevelSetting)
                        
                        SettingButton(label: "Practice",
                                      type: "accuracyLevel",
                                      selected: vm.isSelected(label: "Practice", type: "accuracyLevel"),
                                      changeNoteRepresentationSetting: vm.changeNoteRepresentationSetting,
                                      changeNoiseLevelSetting: vm.changeNoiseLevelSetting,
                                      changeAccuracyLevelSetting: vm.changeAccuracyLevelSetting)
                    }
                    
                    Text(vm.settings.accuracyLevel.getDescription())
                        .font(.label.xsmall)
                        .foregroundColor(.neutral.onBackgroundVariant)
                    
                    Spacer()
                        .frame(height: 24)
                    
                }
                
                Group {
                    Text("Tips")
                        .font(.label.medium)
                    
                    Button {
                        showTutorial.toggle()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack(spacing: 10) {
                            Text("💡")
                                                        
                            Text("New to scentific music? ")
                                .font(.label.small)
                                .foregroundColor(.neutral.onSurface)
                                                        
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color.neutral.surface)
                    .cornerRadius(8)
                }
                                     
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24))
            .foregroundColor(.neutral.onBackground)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    @State static var showTutorial: Bool = false
    
    static var previews: some View {
        SettingView(showTutorial: $showTutorial)
            .environmentObject(SettingViewModel())
    }
}