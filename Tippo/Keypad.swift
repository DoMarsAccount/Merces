//
//  Keypad.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct Keypad: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes = Themes.sharedInstance
    
    var body: some View {
        GeometryReader { geo in
            VStack (spacing: 0) {
                HStack (spacing: 0) {
                    KeypadButton(text: .constant("1"))
                    KeypadButton(text: .constant("2"))
                    KeypadButton(text: .constant("3"))
                }
                HStack (spacing: 0) {
                    KeypadButton(text: .constant("4"))
                    KeypadButton(text: .constant("5"))
                    KeypadButton(text: .constant("6"))
                }
                HStack (spacing: 0) {
                    KeypadButton(text: .constant("7"))
                    KeypadButton(text: .constant("8"))
                    KeypadButton(text: .constant("9"))
                }
                HStack (spacing: 0) {
                    KeypadDoneButton()
                        .accessibility(label: Text("Done"))
                        .accessibility(hint: Text("Closes keypad"))
                    
                    KeypadButton(text: .constant("0"))
                    
                    KeypadDeleteButton()
                        .accessibility(label: Text("Delete"))
                }
            }
//            .background(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
                .background(Color.black)
        }
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            Keypad()
                .frame(maxHeight: 400)
        }
    }
}
