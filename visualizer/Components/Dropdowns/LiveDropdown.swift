//
//  LiveDropdown.swift
//  visualizer
//
//  Created by Mark Cheng on 24/1/2022.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
    }
}

struct LiveDropdown: View {
    @State private var show = false
    @State var value = 3
    
    let start: ()->Void
    let stop: ()->Void
    let options: [Int]
    @Binding var isPitchAccurate: Bool
    
    // timer related
    @State var curTime: Double = 0 // in seconds
    @State var timerIsPaused: Bool = true
    @State var timer: Timer? = nil
    @State var isLive: Bool = true
    
    func resetTimer() {
        curTime = 0
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
    
    func stopAfter(seconds: Int){
        timerIsPaused = false
        start()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){tmpTimer in
            self.curTime = self.curTime + 0.1
            if (!isPitchAccurate) {
                print("not accurate")
                resetTimer()
            }
            if(curTime >= Double(seconds)){
                stopTimer()
            }
            
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if (timerIsPaused){
                VStack(spacing: 0) {
                    Button {
                        isLive ? stop() : start()
                        isLive.toggle()
                    } label: {
                        Image(systemName: isLive ? "waveform.circle.fill" : "waveform")
                            .font(.system(size: isLive ? 28 : 22))
                    }
                    .frame(width: 48, height: 48)
                    .foregroundColor(.neutral.onSurface)
                    .clipShape(Circle())
                    .buttonStyle(ScaleButtonStyle())
                                        
                    if show {
                        ForEach(options, id: \.self){option in
                            Button(action: {
                                self.value = option
                                self.stopAfter(seconds: option)
                                self.show.toggle()
                            }){
                                Text("\(String(option))s")
                            }
                            .frame(width: 48, height: 48)
                            .font(.label.large)
                            .foregroundColor(.neutral.onSurface)
                        }
                    }
                                        
                    Button {
                        show.toggle()
                    } label: {
                        Image(systemName: "chevron.down.circle")
                            .frame(width: 48, height: 48)
                            .foregroundColor(.neutral.onSurface)
                            .clipShape(Circle())
                            .font(.system(size: 22))
                            .rotationEffect(Angle.degrees(show ? 180 : 0))
                            .animation(.spring())
                    }
                }
            }else{
                Button(action: {
                    self.stopTimer()
                    self.show.toggle()
                }){
                    Text("\(String(value - Int(floor(curTime))))")
                }
                    .frame(width: 48, height: 48)
                    .font(.label.large)
                    .background(Color.neutral.surface)
                .foregroundColor(.neutral.onSurface)
            }
        }
        .padding([.top, .bottom], timerIsPaused ? 4 : 0)
        .background(Color.neutral.surface)
        .cornerRadius(45)
        .animation(.spring(), value: show)
    }
}

struct LiveDropdown_Previews: PreviewProvider {
    @State static var isPitchAccurate: Bool = AudioViewModel().isPitchAccurate
    
    static var previews: some View {
        LiveDropdown(start: AudioViewModel().start,
                     stop: AudioViewModel().stop,
                     options: [3, 5, 10],
                     isPitchAccurate: $isPitchAccurate
        ).previewLayout(.sizeThatFits)
    }
}
