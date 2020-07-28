//
//  ContentView.swift
//  TippoWatch Extension
//
//  Created by Donovan McCray on 7/28/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var wCalcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    
    var body: some View {
        ValuesView()
            .navigationBarTitle("Tippo")
            .environmentObject(wCalcModel)
            .environmentObject(userPrefs)
            .onAppear {
                self.wCalcModel.tipRate = Tipping.sharedInstance.currentTipRate(for: self.wCalcModel.selectedVenue, service: self.wCalcModel.service)
                _ = self.wCalcModel.computeTippingValues()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
