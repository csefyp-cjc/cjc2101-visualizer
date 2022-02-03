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
    var tutorials: [InteractiveTutorial]
    
    @Binding var currentPage: Int;
    @Binding var showTutorial: Bool;
    
    func handleNextInstruction() {
        if (currentPage < tutorials.count - 1) {
            currentPage += 1
        } else {
            currentPage = 0
            showTutorial.toggle()
        }
    }
    
    var body: some View {
        ZStack {
            Color.neutral.overlay
                .mask(
                    Highlight(
                        size: tutorials[currentPage].size,
                        offsetX: tutorials[currentPage].offset.width,
                        offsetY: tutorials[currentPage].offset.height
                    )
                        .fill(style: FillStyle(eoFill: true))
                )
                .ignoresSafeArea(.all)
                .onTapGesture {
                    handleNextInstruction()
                }
                .animation(.default)
            
            VStack {
                Text(tutorials[currentPage].text)
                    .padding(16)
                    .foregroundColor(.neutral.onBackground)
                    .background(Color.neutral.background)
                    .font(.text.paragraph)
                    .cornerRadius(14)
                    .position(x: tutorials[currentPage].textPosition.width,
                              y: tutorials[currentPage].textPosition.height)
                
            }
            .padding(.horizontal, 16)
            
            
        }
    }
}

struct InteractiveTutorial_Previews: PreviewProvider {
    @State static private var currentPage = 0
    @State static private var showTutorial = true
    
    static var previews: some View {
        InteractiveTutorialView(
            tutorials: [
                InteractiveTutorial(text: "Pitch and frequencies are correlated. The x-axis here is the letter name of musical notes.",
                                    textPosition: CGSize(width: 0, height: 0),
                                    size: CGSize(width: 350, height: 28),
                                    offset: CGSize(width: 0, height: 350))],
            currentPage: $currentPage,
            showTutorial: $showTutorial
        )
    }
}
