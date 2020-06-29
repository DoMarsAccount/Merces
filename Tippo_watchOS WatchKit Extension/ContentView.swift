//
//  ContentView.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/7/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = false
    @ObservedObject var wCalcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @State private var doesUserWantSetup: Bool = false
    
    var body: some View {
        ValuesView()
            .navigationBarTitle("Tippo")
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
                self.wCalcModel.tipRate = Tipping.sharedInstance.currentTipRate(for: self.wCalcModel.selectedVenue, service: self.wCalcModel.service)
                _ = self.wCalcModel.computeTippingValues()
            }
            .modifier(SetupAlert(isActive: self.$userPrefs.shouldShowSetupAlert, doesUserWantSetup: self.$doesUserWantSetup))
            .sheet(isPresented: self.$doesUserWantSetup) {
                MyMerces().environmentObject(self.userPrefs)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
