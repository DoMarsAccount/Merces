//
//  MainPageSwiftUI.swift
//  TipTok
//
//  Created by Donovan McCray on 6/14/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct MainPageSwiftUI: View {
    @State private var isSettingsActive: Bool = false
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var activeField: EditableTextFields = .none
    
    var body: some View {
        NavigationView {
            VStack {
                MainPageTopSubview(activeField: self.$activeField).padding(.top)
                MainPageMiddleSubview(activeField: self.$activeField)
                if (self.activeField == .none) {
                    MainPageBottomSubview()
                        .padding(.bottom)
                } else if (self.activeField == EditableTextFields.venue) {
                    VenueSelectionView(activeField: self.$activeField)
                } else {
                    Keypad(activeField: self.$activeField)
                }
            }
            .padding([.leading, .trailing])
            .navigationBarTitle(Text("TipTok").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                , displayMode: .automatic)
                
//            .background(NavigationConfigurator { nc in
//                nc.navigationBar.barTintColor = coloringThemes.mainColor
//                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.mainColor, isFlat: true)!]
//            })
//            .background(Color(coloringThemes.backgroundColor))
//            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(trailing: NavigationLink(destination: Settings(), isActive: self.$isSettingsActive) {
                Image(systemName: "gear")
                    .resizable()
                    .accentColor(.primary)
                    .frame(width: 30, height: 30)
                    .accessibility(label: Text("Settings"))
            })
        }
//    .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainPageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        MainPageSwiftUI()
            .environmentObject(UserPreferences.sharedInstance)
//            .environment(\.colorScheme, .dark)
    }
}
