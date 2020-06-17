//
//  Keypad.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct Keypad: View {
    @Binding var activeField: EditableTextFields
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 1) {
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("1"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                    KeypadButton(text: .constant("2"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                    KeypadButton(text: .constant("3"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                }
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("4"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                    KeypadButton(text: .constant("5"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                    KeypadButton(text: .constant("6"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                }
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("7"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                    KeypadButton(text: .constant("8"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                    KeypadButton(text: .constant("9"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                }
                HStack (spacing: 1) {
                    KeypadDoneButton(activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                    KeypadButton(text: .constant("0"), activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                    KeypadDeleteButton(activeField: self.$activeField)
                    .border(Color.primary, width: 2)
                }
            }
            .modifier(TTCardModifier())
        }
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        Keypad(activeField: .constant(.subtotal))
    }
}
