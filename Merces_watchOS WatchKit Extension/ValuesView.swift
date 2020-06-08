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
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            EditableSubtotalValueView(value: self.$wCalcModel.subtotal)
            .onTapGesture {
                self.isPresented.toggle()
            }
            .sheet(isPresented: self.$isPresented) {
                Keypad(value: self.$wCalcModel.subtotal, isPresented: self.$isPresented)
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
