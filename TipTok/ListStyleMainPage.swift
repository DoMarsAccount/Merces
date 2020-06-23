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
    @State private var activeField: EditableTextFields = .none
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    @Binding var value: Double
    var inputStyle: InputStyles
    
    var body: some View {
        VStack {
            ListInputRow(activeField: self.$activeField, value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal)
            
            ListInputRow(activeField: self.$activeField, value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax)
            
            ListInputRow(activeField: self.$activeField, value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize)
            
            ListInputRow(activeField: self.$activeField, value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate)
            
            VStack {
                if (self.calcModel.tipAmount != 0) {
                    ListDisplayRow(value: self.$calcModel.tipAmount, inputStyle: .Currency, title: "Tip Amount")
                }
                
                if (self.calcModel.partySize != 1) {
                    ListDisplayRow(value: self.$calcModel.totalAmountPerPerson, inputStyle: .Currency, title: "Total Per Person")
                }
                
                ListDisplayRow(value: self.$calcModel.totalAmount, inputStyle: .Currency, title: "Grand Total", background: Color(.black).opacity(0.07))
            }
            
        }.padding()
    }
}

struct ListStyleMainPage_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleMainPage(value: .constant(420.69), inputStyle: .Currency)
    }
}

struct ListInputRow: View {
    @Binding var activeField: EditableTextFields
    @Binding var value: Double
    var inputStyle: InputStyles
    var title: String
    var background: Color = .white
    var field: EditableTextFields
    
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
            .foregroundColor(.primary)
            .modifier(AdaptiveCardBackground(backgroundColor: self.background))
            
        }
    }
}

struct ListDisplayRow: View {
    @Binding var value: Double
    var inputStyle: InputStyles
    var title: String
    var background: Color = .white
    
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
        .foregroundColor(.primary)
        .modifier(AdaptiveCardBackground(backgroundColor: self.background))
    }
}
