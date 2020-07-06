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
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    @Binding var isEnabled: Bool
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var themes = Themes.sharedInstance
    
    var body: some View {
        let toggleApperance = UISwitch.appearance()
        toggleApperance.onTintColor = colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark
        
        return Toggle(isOn: self.$isEnabled) {
            Text(self.text)
            .font(Font(self.userPrefs.headlineFont(size: 18)))
        }
    }
}

struct Settings: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @ObservedObject var layoutPrefs = LayoutPreferences.sharedInstance
    @State private var isThemesPageActive: Bool = false
    @State private var isSettingsActive: Bool = false
    @State private var isVenuesSelectionListActive: Bool = false
    @State private var isAboutPageActive: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance").font(Font(self.userPrefs.headlineFont(size: 18)))) {
                    NavigationLink(destination: ThemesPage(), isActive: self.$isThemesPageActive) {
                        Text("Themes")
                            .foregroundColor(.primary)
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                    }
                }
                
                Section(header: Text("Venues").font(Font(self.userPrefs.headlineFont(size: 18)))) {
                    SettingsRow(text: .constant("Display Venue-related Views"), isEnabled: self.$layoutPrefs.displayVenueCards)
                    NavigationLink(destination: VenueSelectionList(), isActive: self.$isVenuesSelectionListActive) {
                        Text("Edit Venues")
                            .foregroundColor(.primary)
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                    }
                }
                
                Section(header: Text("Accessibility").font(Font(self.userPrefs.headlineFont(size: 18)))) {
                    SettingsRow(text: .constant("Use Your iPhone's Text Size"), isEnabled: self.$userPrefs.useDynamicText)
                    SettingsRow(text: .constant("Reduce Haptics"), isEnabled: self.$userPrefs.reduceHaptics)
//                    SettingsRow(text: .constant("Use Flat Views"), isEnabled: self.$preferences.useFlatStyleViews)
                }
                
                Section(header: Text("Feedback").font(Font(self.userPrefs.headlineFont(size: 18)))) {
                    Button(action: {
                        SKStoreReviewController.requestReview()
                    }) {
                        Text("Leave a Rating")
                            .foregroundColor(.primary)
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                    }
                }
                
                Section(footer: Text("Made by Donovan McCray in Baytown, TX").font(Font(self.userPrefs.headlineFont(size: 18)))) {
                    
                    NavigationLink(destination: AboutPage(), isActive: self.$isAboutPageActive) {
                        Text("About Tippo")
                        .font(Font(self.userPrefs.headlineFont(size: 18)))
                    }
                }
                
            }
            .navigationBarTitle(Text("Settings"))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

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

struct SettingsPageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(UserPreferences.sharedInstance)
//        CalculationLogicControls().environmentObject(UserPreferences.sharedInstance)
    }
}
