import SwiftUI

struct ContentView: View {
    @EnvironmentObject var audioViewModel: AudioViewModel
    
    @State private var selection = 2
    
    //TODO: tab view animation
    var body: some View {
        TabView(selection: $selection){
            SoundView().tabItem{
                Label("Sound", systemImage: "waveform.and.magnifyingglass")
                    .environmentObject(audioViewModel)
            }.tag(1)
            PitchView().tabItem{
                Label("Pitch", systemImage: "music.note.list").environmentObject(audioViewModel)
            }.tag(2)
            TimbreView().tabItem{
                Label("Timbre", systemImage: "waveform.path.ecg")
            }.tag(3)
        }.accentColor(.foundation.primary)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone-XR"))
        ContentView().environmentObject(AudioViewModel())
    }
}
