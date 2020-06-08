//
//  ValuesView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ValuesView: View {
//    @State var wholeNumbersPlace: Double = 0.0
//    @State var decimalNumbersPlace: Double = 0.0
    
    @EnvironmentObject var wCalcModel: CalculationsModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            StaticCurrencyValueView(title: .constant("Subtotal:"), value: self.$wCalcModel.subtotal)
            
            HStack {
                EditableIntegerValueView(title: .constant("$"), value: self.$wCalcModel.subtotal)
//                EditableIntegerValueView(title: .constant("."), value: self.$decimalNumbersPlace)
            }
            
            StaticCurrencyValueView(title: .constant("Sales Tax:"), value: self.$wCalcModel.taxAmount)
            
            HStack {
                EditableIntegerValueView(title: .constant("For"), value: self.$wCalcModel.partySize.double)
                            
                EditablePercentageValueView(title: .constant(""), value: self.$wCalcModel.tipRate)
            }
            
            StaticCurrencyValueView(title: .constant("Tip: "), value: self.$wCalcModel.tipAmount)
            
            if (self.wCalcModel.partySize != 1) {
                StaticCurrencyValueView(title: .constant("Per person"), value: self.$wCalcModel.totalAmountPerPerson)
            }
            
            StaticCurrencyValueView(title: .constant("Total: "), value: self.$wCalcModel.totalAmount)
        }
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
    }
}

struct ValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ValuesView().environmentObject(CalculationsModel())
    }
}
