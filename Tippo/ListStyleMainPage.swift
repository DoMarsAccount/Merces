//
//  ListStyleMainPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/22/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ListStyleMainPage: View {
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
                
                VStack {
                    VStack {
                        ListInputRow(value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                        
                        if !self.userPrefs.subtotalIsPostTax {
                            ListInputRow(value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                        }
                        
                        ListInputRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                        
                        Button(action: {
                            self.inputs.activeField = .venue
                        }) {
                            ZStack {
                                
                                HStack {
                                    Text("Venue")
                                        .font(.title)
                                    
                                    Spacer()
                                    
                                    Text(self.calcModel.selectedVenue.name)
                                        .font(.largeTitle)
                                }
                                .padding()
                                .minimumScaleFactor(0.8)
                            }
                            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
                            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark))
                            
                        }
                        
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
                .padding()
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
//        .background(NavigationConfigurator { nc in
//            nc.navigationBar.backgroundColor = (self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
//            nc.navigationBar.barTintColor = (self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
//            nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
//            nc.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
//            nc.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)
//        })
    }
}

struct ListStyleMainPage_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleMainPage().environmentObject(UserPreferences.sharedInstance)
    }
}

struct ListInputRow: View {
    @Binding var value: Double
    @ObservedObject var inputs = InputProcessing.sharedInstance
    var inputStyle: InputStyles
    var title: String
    var field: EditableTextFields
    var background: UIColor = .white
    
    var body: some View {
        Button(action: {
            self.inputs.activeField = self.field
        }) {
            ZStack {
                
                HStack {
                    Text(self.title)
                        .font(.title)
                    
                    Spacer()
                    
                    if self.inputStyle == .Currency {
                        Text(nForm.roundForCurrency(number: self.value)).font(.largeTitle)
                    } else if inputStyle == .TwoDecimalPercent {
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value)).font(.largeTitle)
                    } else if inputStyle == .ThreeDecimalPercent {
                        Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value)).font(.largeTitle)
                    } else {
                        Text(nForm.formatIntegerNumbers(Int(self.value))).font(.largeTitle)
                    }
                }
                .padding()
                .minimumScaleFactor(0.8)
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.background, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.background))
            
        }
    }
}

struct ListDisplayRow: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @Binding var value: Double
    var inputStyle: InputStyles
    var title: String
    
    var body: some View {
        ZStack {
            HStack {
                Text(self.title)
                    .font(.title)
                
                Spacer()
                
                if self.inputStyle == .Currency {
                    Text(nForm.roundForCurrency(number: self.value)).font(.largeTitle)
                } else if inputStyle == .TwoDecimalPercent {
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value)).font(.largeTitle)
                } else if inputStyle == .ThreeDecimalPercent {
                    Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value)).font(.largeTitle)
                } else {
                    Text(nForm.formatIntegerNumbers(Int(self.value))).font(.largeTitle)
                }
            }
            .padding()
            .minimumScaleFactor(0.8)
        }
        .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isFlat: true)))
        .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isInputCard: false))
    }
}
