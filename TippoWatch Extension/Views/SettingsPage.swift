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
    @EnvironmentObject var userPrefs: UserPreferences
    
    var body: some View {
        Toggle(isOn: self.$isEnabled) {
            Text(self.text)
            .font(Font(self.userPrefs.headlineFont(size: headlineTextSize)))
                .accessibility(label: Text(self.text))
        }
    }
}

struct SettingsPage: View {
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var isLocalSalesTaxPageActive: Bool = false
    @State private var isVenueEditPageActive: Bool = false
    
    var body: some View {
        /*
         * Tip Includes Tax
         * Subtotal is Post Tax
         * Round Up Grand Total
         * Round Up Tip Amount
         * Use Accessibility Text
         */
        
        Form {
            Section(header: Text("General").font(Font(self.userPrefs.headlineFont(size: headlineTextSize)))
                .accessibility(label: Text("General"))
                )
            {
                NavigationLink(destination: LocalSalesTaxPage(), isActive: self.$isLocalSalesTaxPageActive) {
                    Text("Local Sales Tax")
                        .font(Font(self.userPrefs.headlineFont(size: headlineTextSize)))
                        .accessibility(label: Text("Local Sales Tax"))
                }
                NavigationLink(destination: VenueEditingView(), isActive: self.$isVenueEditPageActive) {
                    Text("Edit Venues")
                        .font(Font(self.userPrefs.headlineFont(size: headlineTextSize)))
                        .accessibility(label: Text("Edit Venues"))
                }
            }
            
            Section(header: Text("Include Sales Tax in...").font(Font(self.userPrefs.headlineFont(size: headlineTextSize)))
                .accessibility(label: Text("Include Sales Tax in"))
                )
            {
                SettingsRow(text: .constant("Subtotal"), isEnabled: self.$userPrefs.subtotalIsPostTax)
                SettingsRow(text: .constant("Tip"), isEnabled: self.$userPrefs.tipIncludeTax)
            }
            
            Section(header: Text("Round Up to Nearest Dollar").font(Font(self.userPrefs.headlineFont(size: headlineTextSize)))
                .accessibility(label: Text("Round Up to Nearest Dollar"))
                )
            {
                SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$userPrefs.roundTipAmount)
                SettingsRow(text: .constant("Grand Total"), isEnabled: self.$userPrefs.roundTotalAmount)
            }
            
            Section(header: Text("Accessibility")
                .font(Font(self.userPrefs.headlineFont(size: headlineTextSize)))
                .accessibility(label: Text("Accessibility"))
                )
            {
                SettingsRow(text: .constant("Use System Text Size"), isEnabled: self.$userPrefs.useDynamicText)
            }
        }
    }
}

struct LocalSalesTaxPage: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var isKeypadPresented: Bool = false
    
    var body: some View {
        VStack(spacing: viewHeight) {
            Text("Local Sales Tax Rate")
                .cardStyled(value: self.$preferences.localSalesTax, style: .percentage, backgroundColor: Color("TippoIndigo"))
                .onTapGesture {
                    self.isKeypadPresented.toggle()
                }
                .sheet(isPresented: self.$isKeypadPresented) {
                    Keypad(value: self.$preferences.localSalesTax, isPresented: self.$isKeypadPresented, activeField: .constant(.localTax))
                }
                .accessibility(label: Text("Local Sales Tax Rate: \(nForm.roundForPercentWithThreeDecimalPlaces(number: self.preferences.localSalesTax))"))
        }
        .navigationBarTitle("Done")
    }
}

struct VenueEditingView: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var isKeypadPresented: Bool = false
    
    var body: some View {
        VStack(spacing: viewHeight) {
            VenuesView()
                .padding([.top])
        }
        .navigationBarTitle("Done")
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage().environmentObject(UserPreferences.sharedInstance)
//        LocalSalesTaxPage().environmentObject(UserPreferences.sharedInstance)
    }
}
