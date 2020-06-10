//
//  ValuesView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ValuesView: View {
    
    @EnvironmentObject var wCalcModel: CalculationsModel
    @State private var isSubtotalKeypadPresented: Bool = false
    @State private var isTaxAmountKeypadPresented: Bool = false
    @State private var isPartySizeKeypadPresented: Bool = false
    @State private var isTipRateKeypadPresented: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 80) {
                
                KeypadEditableCurrencyValueView(title: .constant("Subtotal:"), value: self.$wCalcModel.subtotal)
                .onTapGesture {
                    self.isSubtotalKeypadPresented.toggle()
                }
                .sheet(isPresented: self.$isSubtotalKeypadPresented) {
                    Keypad(value: self.$wCalcModel.subtotal, isPresented: self.$isSubtotalKeypadPresented, activeField: .constant(.subtotal))
                }
                
                KeypadEditableCurrencyValueView(title: .constant("Tax:"), value: self.$wCalcModel.taxAmount)
                .onTapGesture {
                    self.isTaxAmountKeypadPresented.toggle()
                }
                .sheet(isPresented: self.$isTaxAmountKeypadPresented) {
                    Keypad(value: self.$wCalcModel.taxAmount, isPresented: self.$isTaxAmountKeypadPresented, activeField: .constant(.salesTax))
                }
                
                HStack {
                    KeypadEditableIntegerValueView(title: .constant("For"), value: self.$wCalcModel.partySize.double)
                    .onTapGesture {
                        self.isPartySizeKeypadPresented.toggle()
                    }
                    .sheet(isPresented: self.$isPartySizeKeypadPresented) {
                        Keypad(value: self.$wCalcModel.partySize.double, isPresented: self.$isPartySizeKeypadPresented, activeField: .constant(.numPeople))
                    }
                    
                    KeypadEditablePercentageValueView(title: .constant(""), value: self.$wCalcModel.tipRate)
                    .onTapGesture {
                        self.isTipRateKeypadPresented.toggle()
                    }
                    .sheet(isPresented: self.$isTipRateKeypadPresented) {
                        Keypad(value: self.$wCalcModel.tipRate, isPresented: self.$isTipRateKeypadPresented, activeField: .constant(.tipRate))
                    }
                }
                
                StaticCurrencyValueView(title: .constant("Tip: "), value: self.$wCalcModel.tipAmount)
                
                if (self.wCalcModel.partySize != 1) {
                    StaticCurrencyValueView(title: .constant("Per person"), value: self.$wCalcModel.totalAmountPerPerson)
                }
                
                StaticCurrencyValueView(title: .constant("Total: "), value: self.$wCalcModel.totalAmount)
                
                Spacer()
                
            }
//            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        }
    }
}

struct ValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ValuesView().environmentObject(CalculationsModel())
    }
}
