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
    
    var body: some View {
        let toggleApperance = UISwitch.appearance()
        toggleApperance.onTintColor = colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark
        
        return Toggle(isOn: self.$isEnabled) {
            Text(self.text)
                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
        }
    }
}

struct CalculationLogicControls: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @EnvironmentObject var preferences: UserPreferences
    @State private var isSettingsActive: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Include Sales Tax in...").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$preferences.tipIncludeTax)
                    SettingsRow(text: .constant("Subtotal"), isEnabled: self.$preferences.subtotalIsPostTax)
                }
                
                Section(header: Text("Round Up to Nearest Dollar").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$preferences.roundTipAmount)
                    SettingsRow(text: .constant("Grand Total"), isEnabled: self.$preferences.roundTotalAmount)
                }
                
            }
            .padding(.bottom, 60)
            .background(Color(self.colorScheme == .dark ? .secondarySystemBackground : .systemBackground))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("Rules").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18))))
            .navigationBarItems(leading: Button(action: {
                self.isSettingsActive.toggle()
            }, label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .accessibility(label: Text("Settings"))
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
            }))
            .sheet(isPresented: self.$isSettingsActive) {
                Settings().environmentObject(self.preferences)
            }
        }
    }
}

struct Settings: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @EnvironmentObject var preferences: UserPreferences
    @State private var isPersonalizePageActive: Bool = false
    @State private var isThemesPageActive: Bool = false
    @State private var isSettingsActive: Bool = false
    var body: some View {
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
        NavigationView {
            Form {
                Section(header: Text("General").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    NavigationLink(destination: PersonalizationPage(), isActive: self.$isPersonalizePageActive) {
                        Text("Personalize")
                            .foregroundColor(.primary)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }
                    NavigationLink(destination: ThemesPage(), isActive: self.$isThemesPageActive) {
                        Text("Themes")
                            .foregroundColor(.primary)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }
                }
                
                Section(header: Text("Accessibility").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    SettingsRow(text: .constant("Use Your iPhone's Text Size"), isEnabled: self.$preferences.useDynamicText)
                    SettingsRow(text: .constant("Use Flat Views"), isEnabled: self.$preferences.useFlatStyleViews)
                }
                
                Section(header: Text("Feedback").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    Button(action: {
                        SKStoreReviewController.requestReview()
                    }) {
                        Text("Leave a Rating")
                            .foregroundColor(.primary)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }
                }
                
                Section(header: Text("Extras").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    SettingsRow(text: .constant("Use Classic Layout"), isEnabled: self.$preferences.useClassicStyle)
                }
                
//                Section(header: Text("Support").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
//                    Text("Optimal Usage Guide").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
//                }
//                
//                Section(header: Text("About").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
//                    Text("About Merces").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
//                }
            }
//            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background, isFlat: true)))
            .background(Color(self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("Settings").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18))))
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
                Section(header: Text("General").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    Button(action: {
                        self.isPersonalizePageActive.toggle()
                    }) {
                        Text("Personalize")
                            .foregroundColor(.primary)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }
                    
                    Button(action: {
                        self.isThemesPageActive.toggle()
                    }) {
                        Text("Themes")
                            .foregroundColor(.primary)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }
                    
                    SettingsRow(text: .constant("Include Sales Tax in Tip"), isEnabled: self.$preferences.tipIncludeTax)
                    SettingsRow(text: .constant("Include Sales Tax in Subtotal"), isEnabled: self.$preferences.subtotalIsPostTax)
                }
                
                Section(header: Text("Round Up to Nearest Dollar").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    SettingsRow(text: .constant("Tip Amount"), isEnabled: self.$preferences.roundTipAmount)
                    SettingsRow(text: .constant("Grand Total"), isEnabled: self.$preferences.roundTotalAmount)
                }
                
                Section(header: Text("Accessibility").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    SettingsRow(text: .constant("Use Your iPhone's Text Size"), isEnabled: self.$preferences.useDynamicText)
                    SettingsRow(text: .constant("Use Flat Views"), isEnabled: self.$preferences.useFlatStyleViews)
                }
                
                Section(header: Text("Feedback").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))) {
                    Button(action: {
                        SKStoreReviewController.requestReview()
                    }) {
                        Text("Leave a Rating")
                            .foregroundColor(.primary)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }
                }
            }
//            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background, isFlat: true)))
            .background(Color(self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("Settings"), displayMode: .automatic)
//        }
            
    }
}

struct SettingsPageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(UserPreferences.sharedInstance)
    }
}
