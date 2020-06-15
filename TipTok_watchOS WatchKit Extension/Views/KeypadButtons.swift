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
            case .poorTip:
                varAmts.arrayOfButtonsPressedForPoorTip.append(self.text)
            case .averageTip:
                varAmts.arrayOfButtonsPressedForAverageTip.append(self.text)
            case .greatTip:
                varAmts.arrayOfButtonsPressedForGreatTip.append(self.text)
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
            case .poorTip:
                if (!varAmts.arrayOfButtonsPressedForPoorTip.isEmpty) {
                    varAmts.arrayOfButtonsPressedForPoorTip.removeLast()
                }
            case .averageTip:
                if (!varAmts.arrayOfButtonsPressedForAverageTip.isEmpty) {
                    varAmts.arrayOfButtonsPressedForAverageTip.removeLast()
                }
            case .greatTip:
                if (!varAmts.arrayOfButtonsPressedForGreatTip.isEmpty) {
                    varAmts.arrayOfButtonsPressedForGreatTip.removeLast()
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

struct KeypadButtons_Previews: PreviewProvider {
    static var previews: some View {
        WatchKeypad(value: .constant(0.00), isPresented: .constant(false), activeField: .constant(.localTax))
    }
}
