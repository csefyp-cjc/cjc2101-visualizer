//
//  WatchConnectivityViewModel.swift
//  visualizer
//
//  Created by Andrew Li on 7/2/2022.
//

import Foundation
import WatchConnectivity

class WatchConnectivityViewModel: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    @Published var isWatchLive: Bool = true
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.isWatchLive = Bool(message["message"] as? String ?? "Unknown")!
        }
    }
    
    func toggleWatchLive() {
        self.session.sendMessage(["message" : String(!self.isWatchLive)], replyHandler: nil) { (error) in
//                    print(error.localizedDescription)
        }
        self.isWatchLive = self.isWatchLive ? false : true
    }
}
