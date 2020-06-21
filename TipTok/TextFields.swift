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
        .modifier(MercesStyleTextField())
    }
}

struct IntegerView: View {
    @Binding var value: Int
    var body: some View {
        Text(nForm.formatIntegerNumbers(self.value))
        .modifier(MercesStyleTextField())
    }
}

struct PercentageView: View {
    @Binding var value: Double
    var body: some View {
        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
        .modifier(MercesStyleTextField())
    }
}

struct MercesStyleTextField: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
        .frame(maxWidth: .infinity)
        .padding()
        .border(Color.primary, width: 1)
            .clipShape(RoundedRectangle(cornerRadius: 2.5, style: .circular))
        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 24)))
        .minimumScaleFactor(0.75)
    }
}

struct TextFieldViewModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(
            ZStack {
                Color(self.colorScheme == .dark ? "Eerie" : "Snow")
                
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .foregroundColor(self.colorScheme == .dark ? .secondary : .secondary)
                    .blur(radius: 4)
//                    .offset(x: -8, y: -8)
                
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .foregroundColor(self.colorScheme == .dark ? Color("Eerie") : Color("BabyPowder"))
                    .padding(2)
                    .blur(radius: 2)
                
                if self.colorScheme == .dark {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color("Licorice"), Color("Jet")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .padding(2)
                    .blur(radius: 2)
                } else {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color("BabyPowder"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .padding(2)
                    .blur(radius: 2)
                }
            }
        )
//        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
//        .border(Color.primary, width: 2)
        .shadow(color: self.colorScheme == .dark ? Color("Licorice") : Color("Alabaster"), radius: 2, x: 2, y: 2)
        .shadow(color: self.colorScheme == .dark ? Color("Eerie") : Color("Alabaster"), radius: 2, x: -2, y: -2)
        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 24)))
    }
}

struct TextFields_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(value: .constant(65.89))
    }
}
