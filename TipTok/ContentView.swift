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
        NavigationView {
            if userPrefs.useClassicStyle {
                MainPageSwiftUI()
                    .environmentObject(UserPreferences.sharedInstance)
            } else {
                ListStyleMainPage()
                    .environmentObject(UserPreferences.sharedInstance)
            }
        }
//        .background(NavigationConfigurator { nc in
//            nc.navigationBar.backgroundColor = (self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
//            nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
//            nc.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
//            nc.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)
//        })
//        .modifier(NavigationBarModifier())
//        .navigationViewStyle(StackNavigationViewStyle())
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.colorScheme, .dark)
    }
}
