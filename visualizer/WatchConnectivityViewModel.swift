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
    @Published var isLive: Bool = true
    @Published var pitchNotation: String = "-"
    
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
        switch message["message"] as? String {
        case "TOGGLE_LIVE":
            DispatchQueue.main.async {
                self.isLive = Bool(message["value"] as? String ?? "Unknown")!
            }
        default:
            break
        }
    }
    
    func sendIsLive(isLive: Bool){
        print("sending to watch \(isLive)")
        self.session.sendMessage(["message" : "TOGGLE_LIVE", "value": String(isLive)], replyHandler: nil) { (error) in
            // print(error.localizedDescription)
        }
        self.isLive = isLive
    }
    
    func sendPitchNotation(pitchNotation: String){
        self.session.sendMessage(["message" : "PITCH_NOTATION", "value": pitchNotation], replyHandler: nil) { (error) in
//                    print(error.localizedDescription)
        }
        self.pitchNotation = pitchNotation
    }
}
