//
//  SetupAlertView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/12/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct SetupAlertView: View {
    @State private var isActive: Bool = true
    
    var welcomeText: String = "Welcome to Merces"
    var body: some View {
        let setupButton = Alert.Button.default(
        Text("Setup")
            .foregroundColor(.blue)
        ) {
            print("Going to My Merces...")
        }
        let cancelButton = Alert.Button.cancel(
        Text("Nah")
            .foregroundColor(.purple)
        ) {
            print("Not right now...")
        }
        
        return Text("Sample")
            .alert(isPresented: self.$isActive) {
                Alert(title: Text(welcomeText), message: Text("Lorem ipsum..."), primaryButton: setupButton, secondaryButton: cancelButton)
                

//                Alert.sideBySideButtons(title: Text(welcomeText), message: Text("Lorem ipsum..."), primaryButton: setupButton, secondaryButton: cancelButton)
            }
    }
}

struct SetupAlertView_Previews: PreviewProvider {
    static var previews: some View {
        SetupAlertView()
    }
}
