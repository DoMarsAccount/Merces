//
//  TextFields.swift
//  TipTok
//
//  Created by Donovan McCray on 6/17/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct CurrencyView: View {
    @Binding var value: Double
    var body: some View {
        Text(nForm.roundForCurrency(number: self.value))
        .modifier(TextFieldViewModifier())
    }
}

struct IntegerView: View {
    @Binding var value: Int
    var body: some View {
        Text(nForm.formatIntegerNumbers(self.value))
        .modifier(TextFieldViewModifier())
    }
}

struct PercentageView: View {
    @Binding var value: Double
    var body: some View {
        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
        .modifier(TextFieldViewModifier())
    }
}

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .border(Color.primary, width: 2)
        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
//        .background(Color.secondary)
    }
}

struct TextFields_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(value: .constant(65.89))
    }
}
