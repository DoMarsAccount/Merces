//
//  SettingsPane.swift
//  Tippo
//
//  Created by Donovan McCray on 7/6/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI
import StoreKit

// MARK: Intended for iPad Only
struct SettingsPane: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @EnvironmentObject var preferences: UserPreferences
    @State private var isPersonalizePageActive: Bool = false
    @State private var isThemesPageActive: Bool = false
    
    var body: some View {
//        NavigationView {
            Form {
                Section(header: Text("General").font(Font(self.preferences.headlineFont(size: 18)))) {
                    Button(action: {
                        self.isPersonalizePageActive.toggle()
                    }) {
                        Text("Personalize")
                            .foregroundColor(.primary)
                            .font(Font(self.preferences.headlineFont(size: 18)))
                    }
                    
                    Button(action: {
                        self.isThemesPageActive.toggle()
                    }) {
                        Text("Themes")
                            .foregroundColor(.primary)
                            .font(Font(self.preferences.headlineFont(size: 18)))
                    }
                    
                    SettingsRow(text: .constant("Include Sales Tax in Tip"), isEnabled: self.$preferences.tipIncludeTax)
                    SettingsRow(text: .constant("Include Sales Tax in Subtotal"), isEnabled: self.$preferences.subtotalIsPostTax)
                }
                
                Section(header: Text("Round Up to Nearest Dollar").font(Font(self.preferences.headlineFont(size: 18)))) {
                    SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$preferences.roundTipAmount)
                    SettingsRow(text: .constant("Grand Total"), isEnabled: self.$preferences.roundTotalAmount)
                }
                
                Section(header: Text("Accessibility").font(Font(self.preferences.headlineFont(size: 18)))) {
                    SettingsRow(text: .constant("Use Your iPhone's Text Size"), isEnabled: self.$preferences.useDynamicText)
                    SettingsRow(text: .constant("Use Flat Views"), isEnabled: self.$preferences.useFlatStyleViews)
                }
                
                Section(header: Text("Feedback").font(Font(self.preferences.headlineFont(size: 18)))) {
                    Button(action: {
                        SKStoreReviewController.requestReview()
                    }) {
                        Text("Leave a Rating")
                            .foregroundColor(.primary)
                            .font(Font(self.preferences.headlineFont(size: 18)))
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("Settings"), displayMode: .automatic)
//        }
            
    }
}

struct SettingsPane_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPane().environmentObject(UserPreferences.sharedInstance)
    }
}
