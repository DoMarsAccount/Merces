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
    
    var body: some View {
        NavigationView {
            VStack {
                MainPageTopSubview().padding(.top)
                MainPageMiddleSubview()
                MainPageBottomSubview().padding(.bottom)
            }
            .padding([.leading, .trailing])
            .navigationBarTitle(Text("TipTok").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                , displayMode: .inline)
            
            .navigationBarItems(trailing: NavigationLink(destination: Settings(), isActive: self.$isSettingsActive) {
                Image(systemName: "gear")
                    .resizable()
                    .accentColor(.primary)
                    .frame(width: 30, height: 30)
                    .accessibility(label: Text("Settings"))
            })
        }
    }
}

struct MainPageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        MainPageSwiftUI().environmentObject(UserPreferences.sharedInstance)
//        MainPageTopSubview()
    }
}
