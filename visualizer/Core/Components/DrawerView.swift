//
//  DrawerView.swift
//  visualizer
//
//  Created by Mark Cheng on 15/2/2022.
//

import SwiftUI

struct DrawerView<Content: View>: View {
    @Binding var isShowing: Bool
    @ViewBuilder var content: Content
    @State private var curHeight: CGFloat = 400
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 700
    
    
    var body: some View {
        ZStack(alignment:.bottom){
            if(isShowing){
                Color.neutral.overlay
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        isShowing = false
                    }
                    .animation(.default)
                
                HStack(alignment: .top){
                    content
                }
                .transition(.move(edge: .bottom))
                .frame(height: curHeight, alignment: .top)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                        Rectangle()
                            .frame(height: curHeight/2)
                    }.foregroundColor(.neutral.background)
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(isShowing: .constant(true)){
            Text("test")
        }
    }
}
