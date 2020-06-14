//
//  ValuesView.swift
//  TipTok_watchOS WatchKit Extension
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
    @State private var isDetailedTipRateViewPresented: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(spacing: viewHeight) {
                    HStack {
                        Text("Subtotal")
                            .vCardStyled(value: self.$wCalcModel.subtotal, style: .currency, backgroundColor: .green)
                            .onTapGesture {
                                self.isSubtotalKeypadPresented.toggle()
                            }
                            .sheet(isPresented: self.$isSubtotalKeypadPresented) {
                                Keypad(value: self.$wCalcModel.subtotal, isPresented: self.$isSubtotalKeypadPresented, activeField: .constant(.subtotal))
                            }
                        
                        Text("Tax")
                        .vCardStyled(value: self.$wCalcModel.taxAmount, style: .currency, backgroundColor: .blue)
                        .onTapGesture {
                            self.isTaxAmountKeypadPresented.toggle()
                        }
                        .sheet(isPresented: self.$isTaxAmountKeypadPresented) {
                            Keypad(value: self.$wCalcModel.taxAmount, isPresented: self.$isTaxAmountKeypadPresented, activeField: .constant(.salesTax))
                        }
                    }
                
                    HStack {
                        Text("Tip %")
                            .vCardStyled(value: self.$wCalcModel.tipRate, style: .percentage, backgroundColor: .purple)
//                            .onTapGesture {
//                                self.isTipRateKeypadPresented.toggle()
//                            }
//                            .sheet(isPresented: self.$isTipRateKeypadPresented) {
//                                Keypad(value: self.$wCalcModel.tipRate, isPresented: self.$isTipRateKeypadPresented, activeField: .constant(.tipRate))
//                            }
                            .onTapGesture {
                                self.isDetailedTipRateViewPresented.toggle()
                            }
                            .sheet(isPresented: self.$isDetailedTipRateViewPresented) {
                                DetailedTipRateView(isActive: self.$isDetailedTipRateViewPresented).environmentObject(self.wCalcModel)
                            }
                        
                        
                        Text("Party of")
                        .vCardStyled(value: self.$wCalcModel.partySize.double, style: .integer, backgroundColor: .orange)
                        .onTapGesture {
                            self.isPartySizeKeypadPresented.toggle()
                        }
                        .sheet(isPresented: self.$isPartySizeKeypadPresented) {
                            Keypad(value: self.$wCalcModel.partySize.double, isPresented: self.$isPartySizeKeypadPresented, activeField: .constant(.partySize))
                        }
                    }
                    
                    Text("Tip:")
                        .cardStyled(value: self.$wCalcModel.tipAmount, style: .currency, backgroundColor: .secondary)
                    
                    if (self.wCalcModel.partySize != 1) {
                        Text("Per Person:")
                            .cardStyled(value: self.$wCalcModel.totalAmountPerPerson, style: .currency, backgroundColor: .secondary)
                    }
                    
                    Text("Total:")
                        .cardStyled(value: self.$wCalcModel.totalAmount, style: .currency, backgroundColor: .secondary)
                    
                    Spacer()
                    
                }
                .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            }
        }
    }
}

struct ValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ValuesView().environmentObject(CalculationsModel())
    }
}
