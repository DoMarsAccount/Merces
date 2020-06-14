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

// MARK: - Horizontal Layout, designed for full screen width
struct CurrencyCardStyle: ViewModifier {
    @Binding var value: Double
    var backgroundColor: Color = .black
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            HStack {
                content
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                    .padding()
                    .minimumScaleFactor(0.3)
                
                Spacer()
                
                Text(nForm.roundForCurrency(number: self.value))
                    .padding()
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: title3TextSize)))
                    .minimumScaleFactor(0.8)
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
            HStack {
                content
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                    .padding()
                    .minimumScaleFactor(0.3)
                
                Spacer()
                
                Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                    .padding()
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: title3TextSize)))
                    .minimumScaleFactor(0.8)
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
            HStack {
                content
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                    .padding()
                    .minimumScaleFactor(0.3)
                
                Spacer()
            
                Text(nForm.formatIntegerNumbers(Int(self.value)))
                    .padding()
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: title3TextSize)))
                    .minimumScaleFactor(0.8)
            }
            .frame(width: geo.size.width, height: viewHeight)
            .background(self.backgroundColor)
            .border(self.backgroundColor, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

// MARK: - Vertical Layout, designed for half screen
struct vCurrencyCardStyle: ViewModifier {
    @Binding var value: Double
    var backgroundColor: Color = .black
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                content
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                    .minimumScaleFactor(0.75)
                
                Text(nForm.roundForCurrency(number: self.value))
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: headlineTextSize)))
                    .minimumScaleFactor(0.75)
            }
            .frame(width: geo.size.width, height: viewHeight)
            .background(self.backgroundColor)
            .border(self.backgroundColor, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct vPercentageCardStyle: ViewModifier {
    @Binding var value: Double
    var backgroundColor: Color = .black
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                content
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                    .minimumScaleFactor(0.75)
                
                Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: headlineTextSize)))
                    .minimumScaleFactor(0.75)
            }
            .frame(width: geo.size.width, height: viewHeight)
            .background(self.backgroundColor)
            .border(self.backgroundColor, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct vIntegerCardStyle: ViewModifier {
    @Binding var value: Double
    var backgroundColor: Color = .black
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                content
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                    .minimumScaleFactor(0.75)
            
                Text(nForm.formatIntegerNumbers(Int(self.value)))
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: headlineTextSize)))
                    .minimumScaleFactor(0.75)
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
    
    func vCardStyled(value: Binding<Double>, style: CardStyles, backgroundColor: Color = .black) -> some View {
        Group {
            if (style == .currency) {
                self.modifier(vCurrencyCardStyle(value: value, backgroundColor: backgroundColor))
            } else if (style == .percentage) {
                self.modifier(vPercentageCardStyle(value: value, backgroundColor: backgroundColor))
            } else {
                self.modifier(vIntegerCardStyle(value: value, backgroundColor: backgroundColor))
            }
        }
    }
}

struct CardStylings_Previews: PreviewProvider {
    static var previews: some View {
        Text("Subtotal").vCardStyled(value: .constant(999.99), style: .currency)
    }
}
