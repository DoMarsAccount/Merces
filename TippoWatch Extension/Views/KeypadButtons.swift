//
//  KeypadButtons.swift
//  TipTok_watchOS WatchKit Extension
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
            case .newBadTip:
                self.inputs.arrayOfButtonsNewBadTip.append(self.text)
            case .newGoodTip:
                self.inputs.arrayOfButtonsNewGoodTip.append(self.text)
            case .newGreatTip:
                self.inputs.arrayOfButtonsNewGreatTip.append(self.text)
            default:
                break
            }
        }) {
            Text(self.text)
                .accessibility(label: Text(self.text))
        }
        .cornerRadius(0)
    }
}

struct KeypadDeleteButton: View {
    @Binding var activeField: EditableTextFields
    var inputs = InputProcessing.sharedInstance
    
    var body: some View {
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
            case .newBadTip:
                if (!self.inputs.arrayOfButtonsNewBadTip.isEmpty) {
                    self.inputs.arrayOfButtonsNewBadTip.removeLast()
                }
            case .newGoodTip:
                if (!self.inputs.arrayOfButtonsNewGoodTip.isEmpty) {
                    self.inputs.arrayOfButtonsNewGoodTip.removeLast()
                }
            case .newGreatTip:
                if (!self.inputs.arrayOfButtonsNewGreatTip.isEmpty) {
                    self.inputs.arrayOfButtonsNewGreatTip.removeLast()
                }
            default:
                break
            }
        }) {
            Image(systemName: "delete.left.fill")
                .foregroundColor(.red)
                .accessibility(label: Text("Delete"))
        }
        .cornerRadius(0)
    }
}

struct KeypadDoneButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }) {
            Text("OK")
                .font(.headline)
                .foregroundColor(.green)
                .accessibility(label: Text("Done"))
        }
        .cornerRadius(0)
    }
}
