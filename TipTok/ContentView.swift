//
//  ContentView.swift
//  TipTok
//
//  Created by Donovan McCray on 6/22/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ListStyleMainPage()
//            MainPageSwiftUI()
                .environmentObject(UserPreferences.sharedInstance)
        }
        .navigationViewStyle(StackNavigationViewStyle())
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.colorScheme, .dark)
    }
}
