//
//  ContentView.swift
//  Tippo_iPad
//
//  Created by Donovan McCray on 7/17/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userPrefs = UserPreferences.sharedInstance
    var body: some View {
        NavigationView {
            RegularWidthRegulartHeightListStyle()
                .environmentObject(UserPreferences.sharedInstance)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RegularWidthRegulartHeightListStyle: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var isSettingsActive: Bool = false
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    var body: some View {
        Group {
            if self.horizontalSizeClass == .regular {
                HStack {
                    SettingsPane()
                    
                    VStack {
                        VStack {
                            ListInputRow(value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                .id("\(self.calcModel.subtotal)")
                            
                            HStack {
                                if !self.userPrefs.subtotalIsPostTax {
                                    ListInputHalfRow(value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                        .id("\(self.calcModel.taxAmount)")
                                    
                                    ListInputHalfRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                    .id("\(self.calcModel.partySize)")
                                    
                                } else {
                                
                                ListInputRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                    .id("\(self.calcModel.partySize)")
                                }
                            }
                            
                            HStack {
                                if self.userPrefs.layoutPrefs.displayVenueCards {
                                    VenueHalfButton()
                                        .id("Venue")
                                    
                                    ListInputHalfRow(value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                        .id("\(self.calcModel.tipRate)")
                                } else {
                                    ListInputRow(value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                    .id("\(self.calcModel.tipRate)")
                                }
                            }
                            
                            if self.userPrefs.layoutPrefs.displayVenueCards {
                                ServiceQualityPickerButtons()
                            }
                        }
                        
                        ZStack {
                                VenuePicker()
                                    .offset(x: self.inputs.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
                            
                                Keypad()
                                    .offset(x: (self.inputs.activeField != .none && self.inputs.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
                                
                                ListStyleTotaledAmounts()
                            }
                            .padding(.top)
                            .minimumScaleFactor(0.75)
                    }
                }
            } else {
                GeometryReader { geo in
                    CalculationLogicControls()
                        .environmentObject(self.userPrefs)
                    MainPageSheet(maxHeight: geo.size.height)
                        .environmentObject(self.userPrefs)
                }
            }
        }
//        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
