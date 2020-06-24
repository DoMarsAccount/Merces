//
//  ListStyleMainPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/22/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

enum InputStyles {
    case Currency
    case TwoDecimalPercent
    case ThreeDecimalPercent
    case Integer
}

struct ListStyleMainPage: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var isSettingsActive: Bool = false
    @State private var activeField: EditableTextFields = .none
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    ListInputRow(activeField: self.$activeField, value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
                    if !self.userPrefs.subtotalIsPostTax {
                        ListInputRow(activeField: self.$activeField, value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    }
                    
                    ListInputRow(activeField: self.$activeField, value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
                    ListInputRow(activeField: self.$activeField, value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
//                    HStack {
//
//                    }
                }
                
                ZStack {
                
                    VenueSelectionView(activeField: self.$activeField)
                        .offset(x: self.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
                
                    Keypad(activeField: self.$activeField)
                        .offset(x: (self.activeField != .none && self.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
                    
                    VStack {
                        if (self.calcModel.tipAmount != 0) {
                            ListDisplayRow(value: self.$calcModel.tipAmount, inputStyle: .Currency, title: "Tip Amount")
                        }
                        
                        if (self.calcModel.partySize != 1) {
                            ListDisplayRow(value: self.$calcModel.totalAmountPerPerson, inputStyle: .Currency, title: "Total Per Person")
                        }
                        
                        ListDisplayRow(value: self.$calcModel.totalAmount, inputStyle: .Currency, title: "Grand Total")
                    }
                    .offset(x: self.activeField == .none ? 0 : UIScreen.main.bounds.maxX)
                    
                }
                .frame(maxHeight: geo.size.height / 3)
                .minimumScaleFactor(0.75)
                .animation(.spring(response: 0.7, dampingFraction: 0.7, blendDuration: 1.0))
            }
            .padding()
            .navigationBarTitle(Text("TipTok"), displayMode: .automatic)
            .navigationBarItems(trailing: NavigationLink(destination: Settings(), isActive: self.$isSettingsActive) {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .accessibility(label: Text("Settings"))
                    .accentColor(.primary)
            })
        }
    }
}

struct ListStyleMainPage_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleMainPage()
    }
}

struct ListInputRow: View {
    @Binding var activeField: EditableTextFields
    @Binding var value: Double
    var inputStyle: InputStyles
    var title: String
    var field: EditableTextFields
    var background: UIColor = .white
    
    var body: some View {
        Button(action: {
            self.activeField = self.field
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
            .modifier(AdaptiveCardBackground(backgroundColor: Color(self.background)))
            
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
        .modifier(AdaptiveCardBackground(backgroundColor: Color(self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark)))
    }
}
