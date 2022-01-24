//
//  LiveDropdown.swift
//  visualizer
//
//  Created by Mark Cheng on 24/1/2022.
//

import SwiftUI

struct LiveDropdown: View {
    @State private var show = false
    @State var value = 3
    
    let start: ()->Void
    let stop: ()->Void
    let options: [Int]
    
    // timer related
    @State var curTime: Int = 0 // in seconds
    @State var timerIsPaused: Bool = true
    @State var timer: Timer? = nil
    @State var isLive: Bool = true
    
    func stopAfter(seconds: Int){
        timerIsPaused = false
        start()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){tmpTimer in
            self.curTime = self.curTime + 1
            if(curTime == seconds){
                stopTimer()
            }
            
        }
    }
    
    func stopTimer(){
        print("stop timer")
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
        curTime = 0
        stop()
        isLive = false
    }
    
    var body: some View {
        VStack(spacing: 30) {
            if (timerIsPaused){
                Image(systemName: "waveform")
                    .frame(width: 48, height: 48)
                    .foregroundColor(.neutral.onSurface)
                    .background(Color.neutral.surface)
                    .clipShape(Circle())
                    .font(.system(size: 22))
                    .onTapGesture{
                        self.show.toggle()
                    }
            }else{
                Button(action: {
                    self.stopTimer()
                    self.show.toggle()
                }){
                    Text("\(String(value - curTime))")
                }
                    .frame(width: 48, height: 48)
                    .font(.label.large)
                    .background(Color.neutral.surface)
                    .foregroundColor(.neutral.onSurface)
            }
            
            if show {
                if(isLive){
                    Button(action: {
                        self.stop()
                        self.show.toggle()
                        self.isLive.toggle()
                    }){
                        Image(systemName: "pause.fill")
                    }
                    .offset(x: 0, y: -16)
                    .font(.label.large)
                    .background(Color.neutral.surface)
                    .foregroundColor(.neutral.onSurface)
                }else{
                    Button(action: {
                        self.start()
                        self.show.toggle()
                        self.isLive.toggle()
                    }){
                        Image(systemName: "play.fill")
                    }
                    .offset(x: 0, y: -16)
                    .font(.label.large)
                    .background(Color.neutral.surface)
                    .foregroundColor(.neutral.onSurface)
                }
                ForEach(options, id: \.self){option in
                    Button(action: {
                        self.value = option
                        self.stopAfter(seconds: option)
                        self.show.toggle()
                    }){
                        Text("\(String(option))s")
                    }
                    .offset(x: 0, y: -16)
                    .font(.label.large)
                    .background(Color.neutral.surface)
                    .foregroundColor(.neutral.onSurface)
                }
            }
        }
        .background(Color.neutral.surface)
        .cornerRadius(45)
        .animation(.spring())
    }
}

struct LiveDropdown_Previews: PreviewProvider {
    static var previews: some View {
        LiveDropdown(start: AudioViewModel().start, stop: AudioViewModel().stop, options: [3, 5, 10]).previewLayout(.sizeThatFits)
    }
}
