//
//  KeypadButtons.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

fileprivate var minButtonHeight: CGFloat = 20
fileprivate var minButtonWidth: CGFloat = 50

struct KeypadButton: View {
    @Binding var text: String
    @ObservedObject var inputs = InputProcessing.sharedInstance
    
    var body: some View {
        Button(action: {
            if !UserPreferences.sharedInstance.reduceHaptics { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
            switch self.inputs.activeField {
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
                .frame(minWidth: minButtonWidth, maxWidth: .infinity)
                .frame(minHeight: minButtonHeight, maxHeight: .infinity)
                .padding()
                .accessibility(label: Text(self.text))
                .font(Font(UserPreferences.sharedInstance.headlineFont(size: 48)))
                
        }.buttonStyle(KeypadStyle())
    }
}

struct KeypadDeleteButton: View {
    @ObservedObject var inputs = InputProcessing.sharedInstance
    
    var body: some View {
        Button(action: {
            if !UserPreferences.sharedInstance.reduceHaptics { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
            switch self.inputs.activeField {
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
                .resizable()
                .padding(8)
                .accessibility(label: Text("Delete"))
                .scaledToFit()
        }.buttonStyle(KeypadStyle())
    }
}

struct KeypadDoneButton: View {
    @ObservedObject var inputs = InputProcessing.sharedInstance
    
    var body: some View {
        Button(action: {
            self.inputs.activeField = EditableTextFields.none
            if !UserPreferences.sharedInstance.reduceHaptics { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
        }) {
            Image(systemName: "checkmark")
                .resizable()
                .padding(8)
                .accessibility(label: Text("Done"))
                .accessibility(hint: Text("Removes Keypad"))
                .scaledToFit()
        }.buttonStyle(KeypadStyle())
    }
}

struct KeypadStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes = Themes.sharedInstance
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)), width: 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}


struct KeypadButtons_Previews: PreviewProvider {
    static var previews: some View {
        Keypad()
    }
}
