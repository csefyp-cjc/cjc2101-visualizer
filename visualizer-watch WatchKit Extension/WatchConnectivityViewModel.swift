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
    @Published var pitchNotation: String = "-"
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("watch received a message")
        print(message)
        switch message["message"] as? String {
        case "TOGGLE_LIVE":
            DispatchQueue.main.async {
                self.isLive = Bool(message["value"] as? String ?? "Unknown")!
            }
        case "PITCH_NOTATION":
            DispatchQueue.main.async {
                self.pitchNotation = message["value"] as? String ?? "-"
            }
        default:
            print("watch received some message")
        }
    }
    
    func toggleLive() {
        print("watch sending a message: TOGGLE_LIVE")
        self.session.sendMessage(["message" : "TOGGLE_LIVE", "value": String(!self.isLive)], replyHandler: nil) { (error) in
            // print(error.localizedDescription)
        }
        self.isLive = !self.isLive
    }
}
