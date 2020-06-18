//
//  SettingsPage.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct SettingsRow: View {
    @Binding var text: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        Toggle(isOn: self.$isEnabled) {
            Text(self.text)
            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: headlineTextSize)))
                .accessibility(label: Text(self.text))
        }
    }
}

struct SettingsPage: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var isActive: Bool = false
    
    var body: some View {
        /*
         * Tip Includes Tax
         * Subtotal is Post Tax
         * Round Up Grand Total
         * Round Up Tip Amount
         * Use Accessibility Text
         */
        
        Form {
            Section(header: Text("General").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: headlineTextSize)))
                .accessibility(label: Text("General"))
                )
            {
                NavigationLink(destination: MyMerces(), isActive: self.$isActive) {
                    Text("Personalize")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: headlineTextSize)))
                        .accessibility(label: Text("Personalize"))
                }
                SettingsRow(text: .constant("Tip Includes Sales Tax"), isEnabled: self.$preferences.tipIncludeTax)
//                SettingsRow(text: .constant("Subtotal is Post Tax"), isEnabled: self.$preferences.subtotalIsPostTax)
            }
            
            Section(header: Text("Round Up to Nearest Dollar").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: headlineTextSize)))
                .accessibility(label: Text("Round Up to Nearest Dollar"))
                )
            {
                SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$preferences.roundTipAmount)
                SettingsRow(text: .constant("Grand Total"), isEnabled: self.$preferences.roundTotalAmount)
            }
            
            Section(header: Text("Accessibility")
                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: headlineTextSize)))
                .accessibility(label: Text("Accessibility"))
                )
            {
                SettingsRow(text: .constant("Use System Text Size"), isEnabled: self.$preferences.useDynamicText)
            }
        }
    }
}

struct MyMerces: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var isKeypadPresented: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: viewHeight) {
                Text("Local Sales Tax Rate")
                    .cardStyled(value: self.$preferences.localSalesTax, style: .percentage, backgroundColor: .pink)
                    .onTapGesture {
                        self.isKeypadPresented.toggle()
                    }
                    .sheet(isPresented: self.$isKeypadPresented) {
                        WatchKeypad(value: self.$preferences.localSalesTax, isPresented: self.$isKeypadPresented, activeField: .constant(.localTax))
                    }
                    .accessibility(label: Text("Local Sales Tax Rate: \(nForm.roundForPercentWithThreeDecimalPlaces(number: self.preferences.localSalesTax))"))
                VenuesView().padding([.top])
            }
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage().environmentObject(UserPreferences.sharedInstance)
//        MyMerces().environmentObject(UserPreferences.sharedInstance)
    }
}
