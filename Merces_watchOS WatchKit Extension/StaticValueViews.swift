//
//  StaticValueViews.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct StaticCurrencyValueView: View {
    @Binding var title: String
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Text("\(self.title)")
                        .font(.headline)
                    Spacer()
                }
                Text(nForm.roundForCurrency(number: self.value))
                    .padding()
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .minimumScaleFactor(0.5)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width, height: viewHeight)
            .background(Color.secondary)
            .border(Color.secondary, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct StaticPercentageValueView: View {
    @Binding var title: String
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Text("\(self.title)")
                        .font(.headline)
                    Spacer()
                }
                Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                    .padding()
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .minimumScaleFactor(0.5)
                
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width, height: viewHeight)
            .background(Color.secondary)
            .border(Color.secondary, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct StaticValueViews_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: viewHeight) {
                StaticCurrencyValueView(title: .constant("Subtotal"), value: .constant(4.20))
                
                StaticPercentageValueView(title: .constant("Tip"), value: .constant(0.042))
            }
        }
    }
}

