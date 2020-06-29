//
//  KeypadButtons.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct KeypadButton: View {
    @Binding var text: String
    @Binding var activeField: EditableTextFields
    var inputs = InputProcessing.sharedInstance
    var body: some View {
        GeometryReader { geo in
            Button(action: {
                switch self.activeField {
                case .subtotal:
                    self.inputs.arrayOfButtonsPressedForBillAmountAsString.append(self.text)
                case .salesTax:
                    self.inputs.arrayOfButtonsPressedForTaxAmountAsString.append(self.text)
                case .partySize:
                    self.inputs.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.append(self.text)
                case .tipRate:
                    self.inputs.arrayOfButtonsPressedForTipRateAsString.append(self.text)
                case .localTax:
                    self.inputs.arrayOfButtonsPressedForLocalSalesTax.append(self.text)
                case .badTip:
                    self.inputs.arrayOfButtonsPressedForPoorTip.append(self.text)
                case .goodTip:
                    self.inputs.arrayOfButtonsPressedForAverageTip.append(self.text)
                case .greatTip:
                    self.inputs.arrayOfButtonsPressedForGreatTip.append(self.text)
                default:
                    break
                }
            }) {
                Text(self.text)
                    .padding()
                    .accessibility(label: Text(self.text))
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 36)))
                    
            }
            .cornerRadius(2)
        }
    }
}

struct KeypadDeleteButton: View {
    @Binding var activeField: EditableTextFields
    var inputs = InputProcessing.sharedInstance
    
    var body: some View {
        GeometryReader { geo in
            Button(action: {
                switch self.activeField {
                case .subtotal:
                    if (!self.inputs.arrayOfButtonsPressedForBillAmountAsString.isEmpty) {
                        self.inputs.arrayOfButtonsPressedForBillAmountAsString.removeLast()
                    }
                case .salesTax:
                    if (!self.inputs.arrayOfButtonsPressedForTaxAmountAsString.isEmpty) {
                        self.inputs.arrayOfButtonsPressedForTaxAmountAsString.removeLast()
                    }
                case .partySize:
                    if (!self.inputs.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.isEmpty) {
                        self.inputs.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.removeLast()
                    }
                case .tipRate:
                    if (!self.inputs.arrayOfButtonsPressedForTipRateAsString.isEmpty) {
                        self.inputs.arrayOfButtonsPressedForTipRateAsString.removeLast()
                    }
                case .localTax:
                    if (!self.inputs.arrayOfButtonsPressedForLocalSalesTax.isEmpty) {
                        self.inputs.arrayOfButtonsPressedForLocalSalesTax.removeLast()
                    }
                case .badTip:
                    if (!self.inputs.arrayOfButtonsPressedForPoorTip.isEmpty) {
                        self.inputs.arrayOfButtonsPressedForPoorTip.removeLast()
                    }
                case .goodTip:
                    if (!self.inputs.arrayOfButtonsPressedForAverageTip.isEmpty) {
                        self.inputs.arrayOfButtonsPressedForAverageTip.removeLast()
                    }
                case .greatTip:
                    if (!self.inputs.arrayOfButtonsPressedForGreatTip.isEmpty) {
                        self.inputs.arrayOfButtonsPressedForGreatTip.removeLast()
                    }
                default:
                    break
                }
            }) {
                Image(systemName: "delete.left.fill")
                    .resizable()
                    .padding(8)
                    .accessibility(label: Text("Delete"))
                    .scaledToFit()
            }
        }
    }
}

struct KeypadDoneButton: View {
    @Binding var activeField: EditableTextFields
    
    var body: some View {
        GeometryReader { geo in
            Button(action: {
                self.activeField = EditableTextFields.none
            }) {
                Image(systemName: "checkmark")
                    .resizable()
                    .padding()
                    .accessibility(label: Text("Delete"))
                    .scaledToFit()
            }
            .cornerRadius(0)
        }
    }
}


struct KeypadButtons_Previews: PreviewProvider {
    static var previews: some View {
        Keypad(activeField: .constant(.subtotal))
    }
}
