// use DragGesture to implement touch gesture
// ref: https://betterprogramming.pub/implement-touch-events-in-swiftui-b3a2b0700fd4

import SwiftUI
public enum TouchState{
    case down
    case up
}

public struct TouchEventModifier: ViewModifier {
    @GestureState private var isDown = false
    
    let changeState: (TouchState) -> Void
    
    public func body(content: Content) -> some View {
        let drag = DragGesture(minimumDistance: 0)
                    .updating($isDown) {(value, gestureState, transaction) in
                            gestureState = true
                    }
        return content
            .gesture(drag)
            .onChange(of: isDown, perform: {(down) in
                if(down){
                    self.changeState(.down)
                }else{
                    self.changeState(.up)
                }
            })
    }
    
    public init(changeState: @escaping (TouchState) -> Void) {
        self.changeState = changeState
    }
}


