//
//  CardStylings.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/10/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

let viewHeight: CGFloat = 60

enum CardStyles {
    case currency
    case percentage
    case integer
}

struct CurrencyCardStyle: ViewModifier {
    @Binding var value: Double
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    content.font(.headline).padding(.top)
                    Spacer()
                }
                Text(nForm.roundForCurrency(number: self.value))
                    .padding()
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .minimumScaleFactor(0.5)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width, height: viewHeight)
            .border(Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct PercentageCardStyle: ViewModifier {
    @Binding var value: Double
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    content.font(.headline).padding(.top)
                    Spacer()
                }
                Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                    .padding()
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .minimumScaleFactor(0.5)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width, height: viewHeight)
            .border(Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct IntegerCardStyle: ViewModifier {
    @Binding var value: Double
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    content.font(.headline).padding(.top)
                    Spacer()
                }
                Text(nForm.formatIntegerNumbers(Int(self.value)))
                    .padding()
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .minimumScaleFactor(0.5)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width, height: viewHeight)
            .border(Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

extension View {
    func cardStyled(value: Binding<Double>, style: CardStyles) -> some View {
        Group {
            if (style == .currency) {
                self.modifier(CurrencyCardStyle(value: value))
            } else if (style == .percentage) {
                self.modifier(PercentageCardStyle(value: value))
            } else {
                self.modifier(IntegerCardStyle(value: value))
            }
        }
    }
}

struct CardStylings_Previews: PreviewProvider {
    static var previews: some View {
        Text("Subtotal").cardStyled(value: .constant(0.00), style: .currency)
    }
}
