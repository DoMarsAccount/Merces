//
//  PersonalizationPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/14/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct PersonalizationPage: View {
    @State private var activeField: EditableTextFields = .none
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                PPageTopView(activeField: self.$activeField)
                PPageMiddleView(activeField: self.$activeField)
                if (self.activeField != .none) {
                    Keypad(activeField: self.$activeField)
                } else {
                    PPageBottomView()
                }
            }
            .padding()
        }
        .navigationBarTitle(Text("Personalize").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18))))
    }
}

struct PersonalizationPage_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationPage().environmentObject(UserPreferences.sharedInstance)
    }
}
