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
            print(self.text)
        }) {
            Text(self.text)
        }
        .cornerRadius(0)
    }
}

struct Keypad: View {
    @Binding var text: String
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 1) {
                Spacer()
                Text(self.text)
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
                    KeypadButton(text: .constant("⏎"))
                    KeypadButton(text: .constant("0"))
                    KeypadButton(text: .constant("⌫"))
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height + 65)
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        }
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        Keypad(text: .constant("$0.00"))
    }
}
