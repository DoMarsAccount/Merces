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
//                Section(header: Text("Appearance").font(Font(self.userPrefs.headlineFont(size: 18)))) {
//                    NavigationLink(destination: ThemesPage(), isActive: self.$isThemesPageActive) {
//                        Text("Themes")
//                            .foregroundColor(.primary)
//                            .font(Font(self.userPrefs.headlineFont(size: 18)))
//                    }
//                }
                
                Section(header: Text("Venues").font(Font(self.userPrefs.headlineFont(size: 18)))) {
                    SettingsRow(text: .constant("Display Venue-related Views"), isEnabled: self.$layoutPrefs.displayVenueCards)
                    NavigationLink(destination: VenueEditingView(), isActive: self.$isVenuesSelectionListActive) {
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
                
                Section(footer: SettingsFooter()) {
                    
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

struct SettingsFooter: View {
    @EnvironmentObject var userPrefs: UserPreferences
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Tippo 1.0")
                Text("By Donovan McCray")
                Text("Made in Texas")
            }
                .font(Font(self.userPrefs.subHeadlineFont(size: 18)))
                .padding()
            Spacer()
        }
    }
}

struct SettingsPageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(UserPreferences.sharedInstance)
//        CalculationLogicControls().environmentObject(UserPreferences.sharedInstance)
    }
}
