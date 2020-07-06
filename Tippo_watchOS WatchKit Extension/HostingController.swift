//
//  HostingController.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/7/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import WatchKit
import WatchConnectivity
import SwiftUI

class HostingController: WKHostingController<ContentView>, WCSessionDelegate {
    override var body: ContentView {
        return ContentView()
    }
    
    override func willActivate() {
//        if WCSession.isSupported() {
//            let session = WCSession.default
//            session.delegate = self
//            session.activate()
//        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session on Watch activation did complete")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Received message: \(message)")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Received context: \(applicationContext)")
    }
}
