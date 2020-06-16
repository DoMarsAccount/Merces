//
//  Keypad.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct WatchKeypad: View {
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
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                    
                    if (self.activeField == EditableTextFields.partySize) {
                        Text(nForm.formatIntegerNumbers(Int(self.value)))
                            .multilineTextAlignment(.trailing)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                        
                    } else if (self.activeField == EditableTextFields.subtotal || self.activeField == EditableTextFields.salesTax) {
                        Text(nForm.roundForCurrency(number: self.value))
                        .multilineTextAlignment(.trailing)
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                        
                    } else if (self.activeField == EditableTextFields.localTax) {
                        Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value))
                            .minimumScaleFactor(0.8)
                            .multilineTextAlignment(.trailing)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                        
                    } else {
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                        .multilineTextAlignment(.trailing)
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
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
                    KeypadDoneButton(isPresented: self.$isPresented)
                    KeypadButton(text: .constant("0"), activeField: self.$activeField)
                    KeypadDeleteButton(activeField: self.$activeField)
                }
            }.navigationBarTitle("Done")
            .frame(width: geometry.size.width, height: geometry.size.height + 80)
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        }
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        WatchKeypad(value: .constant(0.00), isPresented: .constant(false), activeField: .constant(.localTax))
    }
}
