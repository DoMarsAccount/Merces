//
//  ContentView.swift
//  TipTok
//
//  Created by Donovan McCray on 6/22/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userPrefs = UserPreferences.sharedInstance
    @ObservedObject var themes = Themes.sharedInstance
    @State private var bottomSheetShown = true
    
    var body: some View {
        GeometryReader { geo in
            CalculationLogicControls()
                .environmentObject(self.userPrefs)
            MainPageSheet(maxHeight: geo.size.height)
                .environmentObject(self.userPrefs)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.colorScheme, .dark)
    }
}
