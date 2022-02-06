import SwiftUI

struct ContentView: View {
    @EnvironmentObject var audioViewModel: AudioViewModel
    
    @State private var selection: Tab = .pitch
    
    enum Tab {
        case sound
        case pitch
        case timbre
    }
    
    //TODO: tab view animation
    var body: some View {
        TabView(selection: $selection){
            SoundView().tabItem{
                Label("Sound", systemImage: "waveform.and.magnifyingglass")
                    .environmentObject(audioViewModel)
            }
            .tag(Tab.sound)
            
            PitchView().tabItem{
                Label("Pitch", systemImage: "music.note.list")
                    .environmentObject(audioViewModel)
            }
            .tag(Tab.pitch)
            
            TimbreView().tabItem{
                Label("Timbre", systemImage: "waveform.path.ecg")
            }
            .tag(Tab.timbre)
        }
        .accentColor(.foundation.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone-XR"))
        ContentView().environmentObject(AudioViewModel())
    }
}
