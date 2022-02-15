//
//  SheetWrapper.swift
//  visualizer
//
//  Created by Mark Cheng on 14/2/2022.
//

import SwiftUI


// a flexible height sheet

enum SheetState {
    case none
    case quarter
    case half
    case full
}

struct SheetWrapper<Content: View>: View {
    let content: () -> Content
    var sheetState: SheetState
    let closeSheet: () -> Void
    
    
    init(sheetState: SheetState, @ViewBuilder content: @escaping () -> Content, closeSheet: @escaping  () -> Void) {
        self.content = content
        self.sheetState = sheetState
        self.closeSheet = closeSheet
    }
    
    private func calcOffset() -> CGFloat{
        switch sheetState {
            case .none:
                return UIScreen.main.bounds.height
            case .quarter:
                return UIScreen.main.bounds.height - 300
            case .half:
                return UIScreen.main.bounds.height/2
            case .full:
                return 0
        }
    }

    
    var body: some View {
        ZStack{
            if(sheetState != .none){
                Color.neutral.overlay
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        closeSheet()
                    }
            }
            
            content()
                .offset(y: calcOffset())
                .animation(.spring())
                .edgesIgnoringSafeArea(.all)
                .zIndex(10)
            
        }
    }
}

struct SheetWrapper_Previews: PreviewProvider {
    
    static private func test(){
        print("test close sheet")
    }
    
    static var previews: some View {
        SheetWrapper(sheetState: .half) {
            VStack {
                Text("Hello World")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        } closeSheet: {
            test()
        }
    }
}
