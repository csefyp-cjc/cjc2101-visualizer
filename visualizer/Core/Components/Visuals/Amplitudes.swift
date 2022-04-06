//
//  Amplitudes.swift
//  visualizer
//
//  Created by Mark Cheng on 6/4/2022.
//

import SwiftUI

struct Amplitudes: View {
    let timer = Timer.publish(
        every: 1 / (UIScreen.screenWidth / 4),
        on: .main,
        in: .common
    ).autoconnect()
    
    let totalBars: Int = Int (UIScreen.screenWidth) / 4
    
    @State var offsets: Array = Array(repeating: CGFloat(0), count: Int(UIScreen.screenWidth) / 4)
    
    var body: some View {
        ScrollView(.horizontal){
            ScrollViewReader { proxy in
                HStack(alignment: .center, spacing: 0){
                    ForEach(0...offsets.count-1, id: \.self){ i in
                        Rectangle()
                            .fill(.red)
                            .frame(width: 3, height: 50 * 0.3)
                            .cornerRadius(4)
                            .frame(maxHeight: 450, alignment: .center)
                            .padding(EdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5))
                            .offset(x: offsets[i])
                            .onReceive(timer){ _ in
                                // reaches max overflow, go back to the start
                                if(self.offsets[i] - CGFloat((totalBars-i) * 8) < -UIScreen.screenWidth * 2){
                                    self.offsets[i] = CGFloat((totalBars-i) * 8)
                                }else{
                                    // move a little bit to left (moving animation)
                                    withAnimation{
                                        self.offsets[i] -= 2
                                    }
                                }
                            }
                    }
                }
                .frame(width: UIScreen.screenWidth * CGFloat(2), alignment: .trailing)
                .overlay(
                    // anchor
                    Rectangle()
//                        .fill(Color.black.opacity(0))
                        .fill(Color.red)
                        .frame(width: 3, height: 15)
                        .padding(EdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5))
                        .offset(x: -UIScreen.screenWidth+8)
                        .id(999999)
                    ,alignment: .trailing
                )
                .onAppear{
                    withAnimation{
                        proxy.scrollTo(999999, anchor: .top)
                    }
                }
            }
        }
    }
}

struct Amplitudes_Previews: PreviewProvider {
    static var previews: some View {
        Amplitudes()
    }
}
