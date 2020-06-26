//
//  WidgetView.swift
//  TipTok
//
//  Created by Donovan McCray on 6/22/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct CondensedKeypad: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var activeField: EditableTextFields
    @ObservedObject var themes = Themes.sharedInstance
    
    var body: some View {
        VStack (spacing: 1) {
            HStack (spacing: 1) {
                KeypadButton(text: .constant("1"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadButton(text: .constant("2"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadButton(text: .constant("3"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadButton(text: .constant("4"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadButton(text: .constant("5"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadDoneButton(activeField: self.$activeField)
                    .modifier(CondensedKeypadModifier())
            }
            HStack (spacing: 1) {
                KeypadButton(text: .constant("6"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadButton(text: .constant("7"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadButton(text: .constant("8"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadButton(text: .constant("9"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadButton(text: .constant("0"), activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
                KeypadDeleteButton(activeField: self.$activeField)
                .modifier(CondensedKeypadModifier())
            }
        }
        .foregroundColor(self.colorScheme == .dark ? .primary : Color(UIColor(contrastingBlackOrWhiteColorOn: themes.background, isFlat: true)))
        .modifier(AdaptiveCardBackground(backgroundColor: themes.mainColor, usePadding: false))
    }
}

struct CondensedKeypadModifier: ViewModifier {
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    func body(content: Content) -> some View {
        content
            .border(Color.primary, width: 1)
            .clipShape(RoundedRectangle(cornerRadius: self.userPrefs.useFlatStyleViews ? 2.5 : 16, style: .continuous))
    }
}

struct WidgetView: View {
    var body: some View {
        CondensedKeypad(activeField: .constant(.none))
    }
}


struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
