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
//        NavigationView {
//            if userPrefs.useClassicStyle {
//                MainPageSwiftUI()
//                    .environmentObject(UserPreferences.sharedInstance)
//            } else {
//                ListStyleMainPage()
//                    .environmentObject(UserPreferences.sharedInstance)
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .modifier(NavigationBarModifier())
        
        GeometryReader { geo in
//            Color.green
            CalculationLogicControls().environmentObject(self.userPrefs)
            CollapsableSheetView(isOpen: self.$bottomSheetShown, maxHeight: geo.size.height * 1.0) {
//                Color.blue
                Group {
                    if self.userPrefs.useClassicStyle {
                        MainPageSwiftUI()
//                            .environmentObject(UserPreferences.sharedInstance)
                    } else {
                        ListStyleMainPage()
//                            .environmentObject(UserPreferences.sharedInstance)
                    }
                }
                .environmentObject(UserPreferences.sharedInstance)
                .padding()
            }
        }
//        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.colorScheme, .dark)
    }
}
