//
//  ContentView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/7/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @ObservedObject var wCalcModel = varAmts.calcModel
    @State private var isActive: Bool = false
    
    var body: some View {
        ValuesView()
            .environmentObject(varAmts.calcModel)
            .contextMenu {
                NavigationLink(destination: SettingsPage().environmentObject(UserPreferences.sharedInstance), isActive: self.$isActive) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings").font(.headline)
                    }
                }
                
            }
        .onAppear {
            _ = varAmts.calcModel.computeTippingValues()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
