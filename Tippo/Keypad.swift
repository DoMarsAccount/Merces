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
            VStack (spacing: 1) {
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("1"))
                    .modifier(KeypadButtonModifier())
                    KeypadButton(text: .constant("2"))
                    .modifier(KeypadButtonModifier())
                    KeypadButton(text: .constant("3"))
                    .modifier(KeypadButtonModifier())
                }
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("4"))
                    .modifier(KeypadButtonModifier())
                    KeypadButton(text: .constant("5"))
                    .modifier(KeypadButtonModifier())
                    KeypadButton(text: .constant("6"))
                    .modifier(KeypadButtonModifier())
                }
                HStack (spacing: 1) {
                    KeypadButton(text: .constant("7"))
                    .modifier(KeypadButtonModifier())
                    KeypadButton(text: .constant("8"))
                    .modifier(KeypadButtonModifier())
                    KeypadButton(text: .constant("9"))
                    .modifier(KeypadButtonModifier())
                }
                HStack (spacing: 1) {
                    KeypadDoneButton()
                        .modifier(KeypadButtonModifier())
                        .accessibility(label: Text("Done"))
                        .accessibility(hint: Text("Closes keypad"))
                    
                    KeypadButton(text: .constant("0"))
                        .modifier(KeypadButtonModifier())
                    
                    KeypadDeleteButton()
                        .modifier(KeypadButtonModifier())
                        .accessibility(label: Text("Delete"))
                }
            }
            .foregroundColor(self.colorScheme == .dark ? Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.mainColorDark, isFlat: true)) : Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.mainColor, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, usePadding: false, isInputCard: false))
//            .frame(maxHeight: geo.size.height / 2.5)
        }
    }
}

struct KeypadButtonModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes = Themes.sharedInstance
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    func body(content: Content) -> some View {
        content
            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)), width: 1)
            .clipShape(RoundedRectangle(cornerRadius: self.userPrefs.useFlatStyleViews ? 2.5 : 16, style: .continuous))
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        Keypad()
    }
}
