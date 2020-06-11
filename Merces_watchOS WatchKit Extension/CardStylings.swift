//
//  CardStylings.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/10/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

let viewHeight: CGFloat = 50

enum CardStyles {
    case currency
    case percentage
    case integer
}

struct CurrencyCardStyle: ViewModifier {
    @Binding var value: Double
    var backgroundColor: Color = .black
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    content
                        .font(.subheadline)
                        .padding()
                        .minimumScaleFactor(0.3)
                    
                    Spacer()
                    
                    Text(nForm.roundForCurrency(number: self.value))
                        .padding()
                        .font(.system(.headline, design: .rounded))
                        .minimumScaleFactor(0.8)
                }
            }
            .frame(width: geo.size.width, height: viewHeight)
            .background(self.backgroundColor)
            .border(self.backgroundColor, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct PercentageCardStyle: ViewModifier {
    @Binding var value: Double
    var backgroundColor: Color = .black
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    content
                        .font(.subheadline)
                        .padding()
                        .minimumScaleFactor(0.3)
                    
                    Spacer()
                    
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                        .padding()
                        .font(.system(.headline, design: .rounded))
                        .minimumScaleFactor(0.8)
                }
                
            }
            .frame(width: geo.size.width, height: viewHeight)
            .background(self.backgroundColor)
            .border(self.backgroundColor, width: 2.5)
            .cornerRadius(2.5)
            
        }
    }
}

struct IntegerCardStyle: ViewModifier {
    @Binding var value: Double
    var backgroundColor: Color = .black
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    content
                        .font(.subheadline)
                        .padding()
                        .minimumScaleFactor(0.3)
                    
                    Spacer()
                
                    Text(nForm.formatIntegerNumbers(Int(self.value)))
                        .padding()
                        .font(.system(.headline, design: .rounded))
                        .minimumScaleFactor(0.8)
                }
            }
            .frame(width: geo.size.width, height: viewHeight)
            .background(self.backgroundColor)
            .border(self.backgroundColor, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

extension View {
    func cardStyled(value: Binding<Double>, style: CardStyles, backgroundColor: Color = .black) -> some View {
        Group {
            if (style == .currency) {
                self.modifier(CurrencyCardStyle(value: value, backgroundColor: backgroundColor))
            } else if (style == .percentage) {
                self.modifier(PercentageCardStyle(value: value, backgroundColor: backgroundColor))
            } else {
                self.modifier(IntegerCardStyle(value: value, backgroundColor: backgroundColor))
            }
        }
    }
}

struct CardStylings_Previews: PreviewProvider {
    static var previews: some View {
        Text("Subtotal").cardStyled(value: .constant(999.99), style: .currency)
    }
}
