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
                
                Text("Subtotal:")
                    .cardStyled(value: self.$wCalcModel.subtotal, style: .currency)
                    .onTapGesture {
                        self.isSubtotalKeypadPresented.toggle()
                    }
                    .sheet(isPresented: self.$isSubtotalKeypadPresented) {
                        Keypad(value: self.$wCalcModel.subtotal, isPresented: self.$isSubtotalKeypadPresented, activeField: .constant(.subtotal))
                    }
                
                Text("Tax:")
                    .cardStyled(value: self.$wCalcModel.taxAmount, style: .currency)
                    .onTapGesture {
                        self.isTaxAmountKeypadPresented.toggle()
                    }
                    .sheet(isPresented: self.$isTaxAmountKeypadPresented) {
                        Keypad(value: self.$wCalcModel.taxAmount, isPresented: self.$isTaxAmountKeypadPresented, activeField: .constant(.salesTax))
                    }
                
                HStack {
                    Text("For")
                        .cardStyled(value: self.$wCalcModel.partySize.double, style: .integer)
                        .onTapGesture {
                            self.isPartySizeKeypadPresented.toggle()
                        }
                        .sheet(isPresented: self.$isPartySizeKeypadPresented) {
                            Keypad(value: self.$wCalcModel.partySize.double, isPresented: self.$isPartySizeKeypadPresented, activeField: .constant(.numPeople))
                        }
                    
                    Text("Tip Rate")
                        .cardStyled(value: self.$wCalcModel.tipRate, style: .percentage)
                        .onTapGesture {
                            self.isTipRateKeypadPresented.toggle()
                        }
                        .sheet(isPresented: self.$isTipRateKeypadPresented) {
                            Keypad(value: self.$wCalcModel.tipRate, isPresented: self.$isTipRateKeypadPresented, activeField: .constant(.tipRate))
                        }
                }
                
                Text("Tip:")
                    .cardStyled(value: self.$wCalcModel.tipAmount, style: .currency, hasBackground: true)
                
                if (self.wCalcModel.partySize != 1) {
                    Text("Per Person:")
                        .cardStyled(value: self.$wCalcModel.totalAmountPerPerson, style: .currency, hasBackground: true)
                }
                
                Text("Total:")
                    .cardStyled(value: self.$wCalcModel.totalAmount, style: .currency, hasBackground: true)
                
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
