//
//  SetupAlertView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/12/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct SetupAlert: ViewModifier {
    @Binding var isActive: Bool
    @Binding var doesUserWantSetup: Bool
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    
    let welcomeText: String = "Welcome to Merces!"
    let message: String = "To save time later, please customize some settings now"
    
    func body(content: Content) -> some View {
        
        let setupButton = Alert.Button.default(
        Text("Okay")
            .foregroundColor(.blue)
        ) {
            self.doesUserWantSetup.toggle()
        }
        
        let cancelButton = Alert.Button.cancel(
        Text("Nope")
            .foregroundColor(.purple)
        ) {
            self.doesUserWantSetup = false
        }
        
        return content
            .alert(isPresented: self.$isActive) {
                Alert(title: Text(welcomeText), message: Text(message), primaryButton: setupButton, secondaryButton: cancelButton)
        }
    }
}
