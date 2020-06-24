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
    @Binding var activeField: EditableTextFields
    @ObservedObject var themes = Themes.sharedInstance
    
    var body: some View {
        VStack (spacing: 1) {
            HStack (spacing: 1) {
                KeypadButton(text: .constant("1"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
                KeypadButton(text: .constant("2"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
                KeypadButton(text: .constant("3"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
            }
            HStack (spacing: 1) {
                KeypadButton(text: .constant("4"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
                KeypadButton(text: .constant("5"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
                KeypadButton(text: .constant("6"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
            }
            HStack (spacing: 1) {
                KeypadButton(text: .constant("7"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
                KeypadButton(text: .constant("8"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
                KeypadButton(text: .constant("9"), activeField: self.$activeField)
                .modifier(CondensedKeypadButton())
            }
            HStack (spacing: 1) {
                KeypadDoneButton(activeField: self.$activeField)
                    .modifier(CondensedKeypadButton())
                    .accessibility(label: Text("Done"))
                    .accessibility(hint: Text("Closes keypad"))
                
                KeypadButton(text: .constant("0"), activeField: self.$activeField)
                    .modifier(CondensedKeypadButton())
                
                KeypadDeleteButton(activeField: self.$activeField)
                    .modifier(CondensedKeypadButton())
                    .accessibility(label: Text("Delete"))
            }
        }
        .foregroundColor(self.colorScheme == .dark ? Color(UIColor(contrastingBlackOrWhiteColorOn: themes.mainColorDark, isFlat: true)) : Color(UIColor(contrastingBlackOrWhiteColorOn: themes.mainColor, isFlat: true)))
        .modifier(AdaptiveCardBackground(backgroundColor: Color(self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark), usePadding: false))
    }
}

struct CondensedKeypadButton: ViewModifier {
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    func body(content: Content) -> some View {
        content
            .border(Color.primary, width: 1)
            .clipShape(RoundedRectangle(cornerRadius: self.userPrefs.useFlatStyleViews ? 2.5 : 16, style: .continuous))
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        Keypad(activeField: .constant(.subtotal))
    }
}
