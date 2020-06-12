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

struct SetupAlertView: View {
    @State private var isActive: Bool = true
    @State private var doesUserWantSetup: Bool = false
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    
    var welcomeText: String = "Welcome to Merces"
    var body: some View {
        GeometryReader { geo in
            NavigationLink(destination: MyMerces().environmentObject(self.userPrefs), isActive: self.$doesUserWantSetup) {
                LaunchView()
                .frame(width: geo.size.width, height: geo.size.height)
                .modifier(SetupAlert(isActive: self.$isActive, doesUserWantSetup: self.$doesUserWantSetup))
            }
        }
    }
}

struct LaunchView: View {
    @State private var isActive: Bool = false
    @ObservedObject var wCalcModel: CalculationsModel = varAmts.calcModel
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    
    var body: some View {
        ValuesView()
            .navigationBarTitle("Merces")
            .environmentObject(wCalcModel)
            .contextMenu {
                NavigationLink(destination: SettingsPage().environmentObject(userPrefs), isActive: self.$isActive) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings").font(.headline)
                    }
                }
                
                Button(action: {
                    self.wCalcModel.resetValues()
                }) {
                    HStack {
                        Image(systemName: "xmark")
                        Text("Clear Values").font(.headline)
                    }
                }
                
            }
            .onAppear {
                self.wCalcModel.tipRate = currentTipRate(for: self.wCalcModel.selectedVenue, service: self.wCalcModel.service)
                _ = self.wCalcModel.computeTippingValues()
            }
            
    }
}

struct SetupAlertView_Previews: PreviewProvider {
    static var previews: some View {
        SetupAlertView()
//        LaunchView()
    }
}
