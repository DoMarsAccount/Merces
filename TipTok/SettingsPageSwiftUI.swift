//
//  SettingsPageSwiftUI.swift
//  TipTok
//
//  Created by Donovan McCray on 6/14/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI
import StoreKit

struct SettingsRow: View {
    @Binding var text: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        Toggle(isOn: self.$isEnabled) {
            Text(self.text)
        }
    }
}

struct Settings: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General").font(.headline)) {
                    NavigationLink(destination: PersonalizationPage(), isActive: self.$isActive) {
                        Text("Personalize")
                    }
                    SettingsRow(text: .constant("Tip Includes Tax"), isEnabled: self.$preferences.tipIncludeTax)
                    SettingsRow(text: .constant("Subtotal is Post Tax"), isEnabled: self.$preferences.subtotalIsPostTax)
                }
                
                Section(header: Text("Round Up to Nearest Dollar").font(.headline)) {
                    SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$preferences.roundTipAmount)
                    SettingsRow(text: .constant("Grand Total"), isEnabled: self.$preferences.roundTotalAmount)
                }
                
                Section(header: Text("Accessibility").font(.headline)) {
                    SettingsRow(text: .constant("Use Your iPhone's Text Size"), isEnabled: self.$preferences.useDynamicText)
                }
                
                Section(header: Text("Feedback").font(.headline)) {
                    Button(action: {
                        
                    }) {
                        Text("Leave a Rating")
                            .foregroundColor(.primary)
                            .onTapGesture {
                                SKStoreReviewController.requestReview()
                        }
                    }
                }
                
                Section(header: Text("Support").font(.headline)) {
                    Text("Optimal Usage Guide")
                }
                
                Section(header: Text("About").font(.headline)) {
                    Text("About Merces")
                }
            }
        }
    }
}

struct SettingsPageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(UserPreferences.sharedInstance)
    }
}
