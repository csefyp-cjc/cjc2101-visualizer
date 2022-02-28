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
    @StateObject private var vm: InteractiveTutorialViewModel
    @Binding var showTutorial: Bool
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var page: InteractiveTutorial.Page
    
    var isCompact: Bool { horizontalSizeClass == .compact}
    
    init(showTutorial: Binding<Bool>, page: InteractiveTutorial.Page) {
        self._vm = StateObject(wrappedValue: InteractiveTutorialViewModel(page: page))
        self._showTutorial = showTutorial
        self.page = page
    }
    
    var body: some View {
        ZStack {
            Color.neutral.overlay
                .mask(
                    Highlight(
                        size: vm.tutorials[vm.currentPage].size,
                        offsetX: vm.tutorials[vm.currentPage].offset.width,
                        offsetY: isCompact ? vm.tutorials[vm.currentPage].offset.height : vm.tutorials[vm.currentPage].offset.height + 64
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
                              y: isCompact ? vm.tutorials[vm.currentPage].textPosition.height : vm.tutorials[vm.currentPage].textPosition.height + 64)
                    .accessibilityIdentifier("Tutorial Hints Text")
                
            }
            .padding(.horizontal, 16)
            
            
        }
    }
}

struct InteractiveTutorial_Previews: PreviewProvider {
    @State static private var currentPage = 1
    @State static private var showTutorial = true
    
    static var previews: some View {
        InteractiveTutorialView(showTutorial: $showTutorial, page: InteractiveTutorial.Page.pitch)
            .environmentObject(InteractiveTutorialViewModel(page: InteractiveTutorial.Page.pitch))
            .previewDevice(PreviewDevice(rawValue: "iPhone-XR"))
        
        InteractiveTutorialView(showTutorial: $showTutorial, page: InteractiveTutorial.Page.pitch)
            .environmentObject(InteractiveTutorialViewModel(page: InteractiveTutorial.Page.pitch))
            .previewDevice(PreviewDevice(rawValue: "iPhone-13-Pro"))
    }
}
