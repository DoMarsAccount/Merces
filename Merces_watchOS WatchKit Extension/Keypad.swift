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
    
    var body: some View {
        Button(action: {
            varAmts.arrayOfButtonsPressedForBillAmountAsString.append(self.text)
        }) {
            Text(self.text)
        }
        .cornerRadius(0)
    }
}

struct KeypadDeleteButton: View {
    @Binding var text: String
    
    var body: some View {
        Button(action: {
            if !varAmts.arrayOfButtonsPressedForBillAmountAsString.isEmpty {
                varAmts.arrayOfButtonsPressedForBillAmountAsString.removeLast()
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
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 1) {
                Spacer()
                Text(nForm.roundForCurrency(number: self.value))
                    .frame(width: geometry.size.width)
                    .multilineTextAlignment(.trailing)
                
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("1"))
                    KeypadButton(text: .constant("2"))
                    KeypadButton(text: .constant("3"))
                }
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("4"))
                    KeypadButton(text: .constant("5"))
                    KeypadButton(text: .constant("6"))
                }
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("7"))
                    KeypadButton(text: .constant("8"))
                    KeypadButton(text: .constant("9"))
                }
                HStack (spacing: 1) {
                    KeypadDoneButton(text: .constant("⏎"), isPresented: self.$isPresented)
                    KeypadButton(text: .constant("0"))
                    KeypadDeleteButton(text: .constant("⌫"))
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
        Keypad(value: .constant(0.00), isPresented: .constant(false))
    }
}
