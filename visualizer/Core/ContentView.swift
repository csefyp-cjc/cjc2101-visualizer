import SwiftUI

struct ContentView: View {
    @EnvironmentObject var audioViewModel: AudioViewModel
    @StateObject var watchConnectivityViewModel = WatchConnectivityViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var selection: Tab = .pitch
    @State private var selectionSidebar: Tab? = .pitch
    
    var isCompact: Bool { horizontalSizeClass == .compact}
    
    enum Tab: CaseIterable, Identifiable {
        case sound
        case pitch
        case timbre
        
        var id: String { title }
        
        var title: String {
            switch self {
            case .sound:
                return "Sound"
            case .pitch:
                return "Pitch"
            case .timbre:
                return "Timbre"
            }
        }
        
        var systemImage: String {
            switch self {
            case .sound:
                return "waveform.and.magnifyingglass"
            case .pitch:
                return "music.note.list"
            case .timbre:
                return "waveform.path.ecg"
            }
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.neutral.background)
      }
    
    //TODO: tab view animation
    var body: some View {
        if isCompact {
            TabView(selection: $selection){
                ForEach(Tab.allCases) { item in
                views(item)
                        .tabItem{
                            Label(item.title, systemImage: item.systemImage)
                        }
                        .tag(item)
                        
                }
            }
            .accentColor(.foundation.primary)
        } else {
            NavigationView {
                List(Tab.allCases, selection: $selectionSidebar) { item in
                    NavigationLink(destination: views(item)
                                    .navigationBarTitle("", displayMode: .inline),
                                   tag: item,
                                   selection: $selectionSidebar
                    ) {
                        Label(item.title, systemImage: item.systemImage)
                            .tag(item)
                    }                    
                }
                .listStyle(SidebarListStyle())
                .navigationBarTitle(Text("Screens"))
            }
            .accentColor(.foundation.primary)
        }
    }
    
    @ViewBuilder
    func views(_ destination: Tab) -> some View {
        switch destination {
        case .sound:
            SoundView()
                .environmentObject(audioViewModel)
        case .pitch:
            PitchView()
                .environmentObject(audioViewModel)
                .environmentObject(watchConnectivityViewModel)
        case .timbre:
            TimbreView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioViewModel())
            .environmentObject(WatchConnectivityViewModel())
    }
}
