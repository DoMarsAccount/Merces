//
//  ListStyleMainPageSizeClassVariations.swift
//  Tippo
//
//  Created by Donovan McCray on 7/1/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ListStyleMainPageSizeClassVariations: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var isSettingsActive: Bool = false
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background)
                    .edgesIgnoringSafeArea(.all)
                
                ZStack {
                    if self.verticalSizeClass == .compact {
                        CompactWidthCompactHeightListStyle()
                    } else {
                        if self.horizontalSizeClass == .compact {
                            CompactWidthRegularHeightListStyle()
                        } else {
                            RegularWidthRegulartHeightListStyle()
                        }
                    }
                }
                .navigationBarTitle(Text("Tippo"), displayMode: .large)
                .navigationBarItems(trailing: NavigationLink(destination: Settings(), isActive: self.$isSettingsActive) {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .accessibility(label: Text("Settings"))
                        .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
                })
            }
        }
    }
}
/// Landscape orientation for Max, Plus iPhones
struct RegularWidthCompactHeightListStyle: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var isSettingsActive: Bool = false
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    ListInputRow(value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
                    if !self.userPrefs.subtotalIsPostTax {
                        ListInputRow(value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    }
                }
                
                HStack {
                    ListInputRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
                    ListInputRow(value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                }
                
                HStack {
                    
                    VenueButton()
                    
                    ZStack {
                    
                        VenueSelectionView()
                            .offset(x: self.inputs.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
                    
                        Keypad()
                            .offset(x: (self.inputs.activeField != .none && self.inputs.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
                        
                        VStack {
                            if (self.calcModel.tipAmount != 0) {
                                ListDisplayRow(value: self.$calcModel.tipAmount, inputStyle: .Currency, title: "Tip Amount")
                            }
                            
                            if (self.calcModel.partySize != 1) {
                                ListDisplayRow(value: self.$calcModel.totalAmountPerPerson, inputStyle: .Currency, title: "Total Per Person")
                            }
                            
                            ListDisplayRow(value: self.$calcModel.totalAmount, inputStyle: .Currency, title: "Grand Total")
                        }
                        .offset(x: self.inputs.activeField == .none ? 0 : UIScreen.main.bounds.maxX)
                        
                    }
                    .frame(maxHeight: geo.size.height / 3)
                    .minimumScaleFactor(0.75)
                    .animation(.spring(response: 0.7, dampingFraction: 0.7, blendDuration: 1.0))
                }
            }
        }
    }
}

/// Landscape orientation for non- Max, Plus iPhones
struct CompactWidthCompactHeightListStyle: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var isSettingsActive: Bool = false
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var minHeight: CGFloat = 88
    var body: some View {
        GeometryReader { geo in
            HStack {
                ScrollView(.vertical) {
                    VStack {
                        ListInputRow(value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark).frame(minHeight: self.minHeight)
                        
                        if !self.userPrefs.subtotalIsPostTax {
                            ListInputRow(value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark).frame(minHeight: self.minHeight)
                        }
                        
                        ListInputRow(value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark).frame(minHeight: self.minHeight)
                        
                        ListInputRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark).frame(minHeight: self.minHeight)
                        
                        VenueButton().frame(minHeight: self.minHeight)
                    }
                }
                
                ZStack {
                    VenueSelectionView()
                        .offset(x: self.inputs.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
                
                    Keypad()
                        .offset(x: (self.inputs.activeField != .none && self.inputs.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
                    
                    VStack {
                        if (self.calcModel.tipAmount != 0) {
                            ListDisplayRow(value: self.$calcModel.tipAmount, inputStyle: .Currency, title: "Tip Amount")
                        }
                        
                        if (self.calcModel.partySize != 1) {
                            ListDisplayRow(value: self.$calcModel.totalAmountPerPerson, inputStyle: .Currency, title: "Total Per Person")
                        }
                        
                        ListDisplayRow(value: self.$calcModel.totalAmount, inputStyle: .Currency, title: "Grand Total")
                    }
                    .offset(x: self.inputs.activeField == .none ? 0 : UIScreen.main.bounds.maxX)
                    
                }
                .minimumScaleFactor(0.75)
                .animation(.spring(response: 0.7, dampingFraction: 0.9, blendDuration: 1.0))
            }
        }
    }
}

/// Standard Portrait layout for all iPhones and compact split-view iPad
struct CompactWidthRegularHeightListStyle: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var isSettingsActive: Bool = false
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    ListInputRow(value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
                    if !self.userPrefs.subtotalIsPostTax {
                        ListInputRow(value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    }
                    
                    ListInputRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
                    VenueButton()
                    
                    ListInputRow(value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                }
            
                ZStack {
                
                    VenueSelectionView()
                        .offset(x: self.inputs.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
                
                    Keypad()
                        .offset(x: (self.inputs.activeField != .none && self.inputs.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
                    
                    VStack {
                        if (self.calcModel.tipAmount != 0) {
                            ListDisplayRow(value: self.$calcModel.tipAmount, inputStyle: .Currency, title: "Tip Amount")
                        }
                        
                        if (self.calcModel.partySize != 1) {
                            ListDisplayRow(value: self.$calcModel.totalAmountPerPerson, inputStyle: .Currency, title: "Total Per Person")
                        }
                        
                        ListDisplayRow(value: self.$calcModel.totalAmount, inputStyle: .Currency, title: "Grand Total")
                    }
                    .offset(x: self.inputs.activeField == .none ? 0 : UIScreen.main.bounds.maxX)
                    
                }
                .frame(maxHeight: geo.size.height / 3)
                .minimumScaleFactor(0.75)
                .animation(.spring(response: 0.7, dampingFraction: 0.7, blendDuration: 1.0))
            }
        }
    }
}

/// Both portrait and landscape orientations for All iPads
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
                    Settings()
                    
                    GeometryReader { geo in
                        VStack {
                            VStack {
                                ListInputRow(value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                
                                if !self.userPrefs.subtotalIsPostTax {
                                    ListInputRow(value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                }
                                
                                ListInputRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                
                                VenueButton()
                                
                                ListInputRow(value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                            }
                        
                            ZStack {
                            
                                VenueSelectionView()
                                    .offset(x: self.inputs.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
                            
                                Keypad()
                                    .offset(x: (self.inputs.activeField != .none && self.inputs.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
                                
                                VStack {
                                    if (self.calcModel.tipAmount != 0) {
                                        ListDisplayRow(value: self.$calcModel.tipAmount, inputStyle: .Currency, title: "Tip Amount")
                                    }
                                    
                                    if (self.calcModel.partySize != 1) {
                                        ListDisplayRow(value: self.$calcModel.totalAmountPerPerson, inputStyle: .Currency, title: "Total Per Person")
                                    }
                                    
                                    ListDisplayRow(value: self.$calcModel.totalAmount, inputStyle: .Currency, title: "Grand Total")
                                }
                                .offset(x: self.inputs.activeField == .none ? 0 : UIScreen.main.bounds.maxX)
                                
                            }
                            .frame(maxHeight: geo.size.height / 3)
                            .minimumScaleFactor(0.75)
                            .animation(.spring(response: 0.7, dampingFraction: 0.7, blendDuration: 1.0))
                        }
                    }
                }
            } else {
                CompactWidthRegularHeightListStyle()
            }
        }
//        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ListStyleMainPageSizeClassVariations_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleMainPageSizeClassVariations().environmentObject(UserPreferences.sharedInstance)
    }
}
