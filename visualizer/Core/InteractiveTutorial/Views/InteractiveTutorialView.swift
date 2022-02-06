//
//  InteractiveTutorialView.swift
//  visualizer
//
//  Created by Andrew Li on 17/1/2022.
//

import SwiftUI

struct Highlight: Shape {
    let size: CGSize
    let offsetX: CGFloat
    let offsetY: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)
        let origin = CGPoint(x: rect.midX - size.width / 2 + offsetX,
                             y: rect.midY - size.height / 2 + offsetY)
        path.addRoundedRect(in: CGRect(origin: origin, size: size), cornerSize: CGSize(width: 9, height: 9))
        return path
    }
}

struct InteractiveTutorialView: View {
    @StateObject private var vm: InteractiveTutorialViewModel = InteractiveTutorialViewModel()
    @Binding var showTutorial: Bool;
    
    var body: some View {
        ZStack {
            Color.neutral.overlay
                .mask(
                    Highlight(
                        size: vm.tutorials[vm.currentPage].size,
                        offsetX: vm.tutorials[vm.currentPage].offset.width,
                        offsetY: vm.tutorials[vm.currentPage].offset.height
                    )
                        .fill(style: FillStyle(eoFill: true))
                )
                .ignoresSafeArea(.all)
                .onTapGesture {
                    vm.handleNextInstruction() ? showTutorial.toggle() : nil
                }
                .animation(.default)
            
            VStack {
                Text(vm.tutorials[vm.currentPage].text)
                    .padding(16)
                    .foregroundColor(.neutral.onBackground)
                    .background(Color.neutral.background)
                    .font(.text.paragraph)
                    .cornerRadius(14)
                    .position(x: vm.tutorials[vm.currentPage].textPosition.width,
                              y: vm.tutorials[vm.currentPage].textPosition.height)
                
            }
            .padding(.horizontal, 16)
            
            
        }
    }
}

struct InteractiveTutorial_Previews: PreviewProvider {
    @State static private var currentPage = 1
    @State static private var showTutorial = true
    
    static var previews: some View {
        InteractiveTutorialView(showTutorial: $showTutorial)
            .environmentObject(InteractiveTutorialViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone-XR"))
        
        InteractiveTutorialView(showTutorial: $showTutorial)
            .environmentObject(InteractiveTutorialViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone-13-Pro"))
    }
}
