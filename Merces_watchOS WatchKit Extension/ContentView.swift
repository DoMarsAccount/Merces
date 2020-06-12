//
//  ContentView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/7/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = false
    @ObservedObject var wCalcModel: CalculationsModel = varAmts.calcModel
    var body: some View {
        ValuesView()
            .navigationBarTitle("Merces")
            .environmentObject(wCalcModel)
            .contextMenu {
                NavigationLink(destination: SettingsPage().environmentObject(UserPreferences.sharedInstance), isActive: self.$isActive) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings").font(.headline)
                    }
                }
                
            }
            .onAppear {
                self.wCalcModel.tipRate = currentTipRate(for: self.wCalcModel.selectedVenue, service: self.wCalcModel.service)
                _ = self.wCalcModel.computeTippingValues()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
