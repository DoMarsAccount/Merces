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
    
    var body: some View {
//        ListStyleMainPageSizeClassVariations().environmentObject(UserPreferences.sharedInstance)
        NavigationView {
            if userPrefs.useClassicStyle {
                MainPageSwiftUI()
                    .environmentObject(UserPreferences.sharedInstance)
            } else {
                ListStyleMainPage()
                    .environmentObject(UserPreferences.sharedInstance)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
//        .modifier(NavigationBarModifier())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.colorScheme, .dark)
    }
}
