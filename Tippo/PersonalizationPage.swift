//
//  PersonalizationPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/14/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct PersonalizationPage: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var activeField: EditableTextFields = .none
    @State private var isThemesPageActive: Bool = false
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
    @ObservedObject var themes = Themes.sharedInstance
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    if !self.userPrefs.useClassicStyle {
                        ListInputRow(activeField: self.$activeField, value: self.$userPrefs.localSalesTax, inputStyle: .ThreeDecimalPercent, title: "Local Sales Tax Rate", field: .localTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    } else {
                        PPageTopView(activeField: self.$activeField)
                    }
                    PPageMiddleView(activeField: self.$activeField)
                    if (self.activeField != .none) {
                        Keypad(activeField: self.$activeField)
                    } else {
                        PPageBottomView()
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle(Text("Personalize"))
    }
}

struct PersonalizationPage_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationPage().environmentObject(UserPreferences.sharedInstance)
    }
}
