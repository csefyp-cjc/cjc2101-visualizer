//
//  WatchConnectivityViewModel.swift
//  visualizer-watch WatchKit Extension
//
//  Created by Andrew Li on 7/2/2022.
//

import Foundation
import WatchConnectivity

class WatchConnectivityViewModel: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    @Published var isLive: Bool = true
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.isLive = Bool(message["message"] as? String ?? "Unknown")!
        }
    }
    
    func toggleLive() {
        self.session.sendMessage(["message" : String(!self.isLive)], replyHandler: nil) { (error) in
//                    print(error.localizedDescription)
        }
        self.isLive = self.isLive ? false : true
    }
}
