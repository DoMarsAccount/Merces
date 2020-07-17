//
//  CalculationLogicControls.swift
//  Tippo
//
//  Created by Donovan McCray on 7/5/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct CalculationLogicControls: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @EnvironmentObject var preferences: UserPreferences
    @State private var isSettingsActive: Bool = false
    @State private var isPersonalizationPageActive: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Include Sales Tax in...").font(Font(self.preferences.headlineFont(size: 18)))) {
                        SettingsRow(text: .constant("Subtotal"), isEnabled: self.$preferences.subtotalIsPostTax)
                        SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$preferences.tipIncludeTax)
                    }
                    
                    Section(header: Text("Round Up to Nearest Dollar").font(Font(self.preferences.headlineFont(size: 18)))) {
                        SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$preferences.roundTipAmount)
                        SettingsRow(text: .constant("Grand Total"), isEnabled: self.$preferences.roundTotalAmount)
                    }
                    Section(header: Text("Auto-calculate Sales Tax").font(Font(self.preferences.headlineFont(size: 18)))) {
                        NavigationLink(destination: PersonalizationPage(), isActive: self.$isPersonalizationPageActive) {
                            Text("Local Sales Tax: \(nForm.roundForPercentWithThreeDecimalPlaces(number: self.preferences.localSalesTax))")
                                .font(Font(self.preferences.headlineFont(size: 18)))
                        }
                    }
                    
                    Section(header: Text(""), footer: Text("")) {
                        Text("Nothing to see here...👀")
                    }.frame(height: 60)
                    
                }
                .navigationBarTitle(Text("Rules"))
                .padding(.bottom, 60)
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarItems(trailing: Button(action: {
                    self.isSettingsActive.toggle()
                }, label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 0))
                        .accessibility(label: Text("Settings"))
                        .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
                }))
                .sheet(isPresented: self.$isSettingsActive) {
                    Settings().environmentObject(self.preferences)
                }
                
                Text("")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(self.colorScheme == .light ? Color(.systemBackground) : Color(.secondarySystemBackground))
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct CalculationLogicControls_Previews: PreviewProvider {
    static var previews: some View {
        CalculationLogicControls()
            .environmentObject(UserPreferences.sharedInstance)
            .environment(\.colorScheme, .dark)
    }
}
