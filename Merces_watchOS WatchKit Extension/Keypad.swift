//
//  Keypad.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct KeypadButton: View {
    @Binding var text: String
    @Binding var activeField: EditableTextFields
    
    var body: some View {
        Button(action: {
            switch self.activeField {
            case .subtotal:
                varAmts.arrayOfButtonsPressedForBillAmountAsString.append(self.text)
            case .salesTax:
                varAmts.arrayOfButtonsPressedForTaxAmountAsString.append(self.text)
            case .partySize:
                varAmts.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.append(self.text)
            case .tipRate:
                varAmts.arrayOfButtonsPressedForTipRateAsString.append(self.text)
            case .localTax:
                varAmts.arrayOfButtonsPressedForLocalSalesTax.append(self.text)
            default:
                break
            }
        }) {
            Text(self.text)
        }
        .cornerRadius(0)
    }
}

struct KeypadDeleteButton: View {
    @Binding var text: String
    @Binding var activeField: EditableTextFields
    
    var body: some View {
        Button(action: {
            switch self.activeField {
            case .subtotal:
                if (!varAmts.arrayOfButtonsPressedForBillAmountAsString.isEmpty) {
                    varAmts.arrayOfButtonsPressedForBillAmountAsString.removeLast()
                }
            case .salesTax:
                if (!varAmts.arrayOfButtonsPressedForTaxAmountAsString.isEmpty) {
                    varAmts.arrayOfButtonsPressedForTaxAmountAsString.removeLast()
                }
            case .partySize:
                if (!varAmts.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.isEmpty) {
                    varAmts.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.removeLast()
                }
            case .tipRate:
                if (!varAmts.arrayOfButtonsPressedForTipRateAsString.isEmpty) {
                    varAmts.arrayOfButtonsPressedForTipRateAsString.removeLast()
                }
            case .localTax:
                if (!varAmts.arrayOfButtonsPressedForLocalSalesTax.isEmpty) {
                    varAmts.arrayOfButtonsPressedForLocalSalesTax.removeLast()
                }
            default:
                break
            }
        }) {
            Text(self.text)
        }
        .cornerRadius(0)
    }
}

struct KeypadDoneButton: View {
    @Binding var text: String
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }) {
            Text(self.text)
        }
        .cornerRadius(0)
    }
}

struct Keypad: View {
    @Binding var value: Double
    @Binding var isPresented: Bool
    @Binding var activeField: EditableTextFields
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 1) {
                Spacer()
                
                HStack {
                    Text("\(self.activeField.name):")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                    
                    if (self.activeField == EditableTextFields.partySize) {
                        Text(nForm.formatIntegerNumbers(Int(self.value)))
                            .multilineTextAlignment(.trailing)
                    } else if (self.activeField == EditableTextFields.tipRate) {
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                            .multilineTextAlignment(.trailing)
                    } else if (self.activeField == EditableTextFields.localTax) {
                        Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value))
                            .minimumScaleFactor(0.8)
                            .multilineTextAlignment(.trailing)
                    } else {
                        Text(nForm.roundForCurrency(number: self.value))
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("1"), activeField: self.$activeField)
                    KeypadButton(text: .constant("2"), activeField: self.$activeField)
                    KeypadButton(text: .constant("3"), activeField: self.$activeField)
                }
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("4"), activeField: self.$activeField)
                    KeypadButton(text: .constant("5"), activeField: self.$activeField)
                    KeypadButton(text: .constant("6"), activeField: self.$activeField)
                }
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("7"), activeField: self.$activeField)
                    KeypadButton(text: .constant("8"), activeField: self.$activeField)
                    KeypadButton(text: .constant("9"), activeField: self.$activeField)
                }
                HStack (spacing: 1) {
                    KeypadDoneButton(text: .constant("⏎"), isPresented: self.$isPresented)
                    KeypadButton(text: .constant("0"), activeField: self.$activeField)
                    KeypadDeleteButton(text: .constant("⌫"), activeField: self.$activeField)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height + 80)
//            .foregroundColor(.green)
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        }
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        Keypad(value: .constant(0.00), isPresented: .constant(false), activeField: .constant(.localTax))
    }
}
