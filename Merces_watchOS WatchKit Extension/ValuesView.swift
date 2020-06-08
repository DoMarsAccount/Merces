//
//  ValuesView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ValuesView: View {
    @State var partySize: Double = 1.0
    @State var tipRate: Double = 22.0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            StaticCurrencyValueView(title: .constant("Subtotal:"), value: .constant(5.25))
            
            StaticCurrencyValueView(title: .constant("Sales Tax:"), value: .constant(0.00))
            
            HStack {
                EditableIntegerValueView(title: .constant("For"), value: self.$partySize)
                            
                EditablePercentageValueView(title: .constant(""), value: self.$tipRate)
            }
            
            StaticCurrencyValueView(title: .constant("Tip: "), value: .constant(4.20))
            
            StaticCurrencyValueView(title: .constant("Per person"), value: .constant(4.20))
            
            StaticCurrencyValueView(title: .constant("Total: "), value: .constant(13.37))
        }
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
    }
}

struct ValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ValuesView()
    }
}
