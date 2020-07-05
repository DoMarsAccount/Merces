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
    @State private var isThemesPageActive: Bool = false
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
    @ObservedObject var themes = Themes.sharedInstance
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ListInputRow(value: self.$userPrefs.localSalesTax, inputStyle: .ThreeDecimalPercent, title: "Local Sales Tax Rate", field: .localTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    PPageBottomView()
                    PPageBottomView()
                }
                .padding()
            }
        }
        .navigationBarTitle(Text("Local Sales Tax"))
    }
}

struct PersonalizationPage_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationPage().environmentObject(UserPreferences.sharedInstance)
    }
}
