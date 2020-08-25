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
                .accessibility(label: Text(self.text))
                .font(Font(UserPreferences.sharedInstance.headlineFont(size: 48)))
                .frame(minWidth: minButtonWidth, maxWidth: .infinity)
                .frame(minHeight: minButtonHeight, maxHeight: .infinity)
                
        }
        .modifier(KeypadButtonModifier())
//        .buttonStyle(KeypadStyle())
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
                .padding()
                .accessibility(label: Text("Delete"))
                .scaledToFit()
                .frame(minWidth: minButtonWidth, maxWidth: .infinity)
                .frame(minHeight: minButtonHeight, maxHeight: .infinity)
        }
//        .buttonStyle(KeypadStyle())
        .modifier(KeypadButtonModifier())
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
                .padding()
                .accessibility(label: Text("Done"))
                .accessibility(hint: Text("Removes Keypad"))
                .scaledToFit()
                .frame(minWidth: minButtonWidth, maxWidth: .infinity)
                .frame(minHeight: minButtonHeight, maxHeight: .infinity)
        }
//        .buttonStyle(KeypadStyle())
        .modifier(KeypadButtonModifier())
    }
}

struct KeypadButtonModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes = Themes.sharedInstance
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    func body(content: Content) -> some View {
        content
            .foregroundColor(self.colorScheme == .dark ? Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.mainColorDark, isFlat: true)) : Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.mainColor, isFlat: true)))
//            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColor, isFlat: true)), width: 1)
            .border(Color.black, width: 1)
            .background(Color(self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor))
//            .background(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
    }
}

struct KeypadStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes = Themes.sharedInstance
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: minButtonWidth, maxWidth: .infinity)
            .frame(minHeight: minButtonHeight, maxHeight: .infinity)
//            .background(Color(self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor))
//            .background(self.colorScheme == .light ? Color(self.themes.mainColor) : Color(self.themes.mainColorDark))
            .scaleEffect(configuration.isPressed ? 0.75 : 1.0)
    }
}


struct KeypadButtons_Previews: PreviewProvider {
    static var previews: some View {
        Keypad()
    }
}
