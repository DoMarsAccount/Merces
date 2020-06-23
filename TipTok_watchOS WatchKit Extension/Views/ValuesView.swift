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
                VStack() {
//                    HStack {
                        Text("Subtotal")
                            .cardStyled(value: self.$wCalcModel.subtotal, style: .currency, backgroundColor: Color("MercesGreen"))
                            .onTapGesture {
                                self.isSubtotalKeypadPresented.toggle()
                            }
                            .sheet(isPresented: self.$isSubtotalKeypadPresented) {
                                WatchKeypad(value: self.$wCalcModel.subtotal, isPresented: self.$isSubtotalKeypadPresented, activeField: .constant(.subtotal))
                            }
                            .accessibility(label: Text("Subtotal: \(nForm.roundForCurrency(number: self.wCalcModel.subtotal) )"))
                            .modifier(scalingEffect())
                        
                    HStack {
                        if !UserPreferences.sharedInstance.subtotalIsPostTax {
                        Text("Sales Tax")
                            .vCardStyled(value: self.$wCalcModel.taxAmount, style: .currency, backgroundColor: Color("MercesGreen"))
                            .onTapGesture {
                                self.isTaxAmountKeypadPresented.toggle()
                            }
                            .sheet(isPresented: self.$isTaxAmountKeypadPresented) {
                                WatchKeypad(value: self.$wCalcModel.taxAmount, isPresented: self.$isTaxAmountKeypadPresented, activeField: .constant(.salesTax))
                            }
                        .accessibility(label: Text("Sales Tax: \(nForm.roundForCurrency(number: self.wCalcModel.taxAmount) )"))
                        .modifier(scalingEffect())
                        
                        Text("Party of")
                            .vCardStyled(value: self.$wCalcModel.partySize.double, style: .integer, backgroundColor: Color("MercesGreen"))
                            .onTapGesture {
                                self.isPartySizeKeypadPresented.toggle()
                            }
                            .sheet(isPresented: self.$isPartySizeKeypadPresented) {
                                WatchKeypad(value: self.$wCalcModel.partySize.double, isPresented: self.$isPartySizeKeypadPresented, activeField: .constant(.partySize))
                            }
                            .accessibility(label: Text("Party Size: \(nForm.formatIntegerNumbers(self.wCalcModel.partySize))"))
                            .modifier(scalingEffect())
                        } else {
                            Text("Party Size")
                            .cardStyled(value: self.$wCalcModel.partySize.double, style: .integer, backgroundColor: Color("MercesGreen"))
                            .onTapGesture {
                                self.isPartySizeKeypadPresented.toggle()
                            }
                            .sheet(isPresented: self.$isPartySizeKeypadPresented) {
                                WatchKeypad(value: self.$wCalcModel.partySize.double, isPresented: self.$isPartySizeKeypadPresented, activeField: .constant(.partySize))
                            }
                            .accessibility(label: Text("Party Size: \(nForm.formatIntegerNumbers(self.wCalcModel.partySize))"))
                            .modifier(scalingEffect())
                        }
                    }
                
//                    HStack {
                        Text("Tip %")
                            .cardStyled(value: self.$wCalcModel.tipRate, style: .percentage, backgroundColor: Color("MercesGreen"))
                            .onTapGesture {
                                self.isDetailedTipRateViewPresented.toggle()
                            }
//                            .onLongPressGesture(minimumDuration: 0.5) {
//                                self.isDetailedTipRateViewPresented.toggle()
//                            }
//                            .sheet(isPresented: self.$isTipRateKeypadPresented) {
//                                WatchKeypad(value: self.$wCalcModel.tipRate, isPresented: self.$isTipRateKeypadPresented, activeField: .constant(.tipRate))
//                            }
                            .sheet(isPresented: self.$isDetailedTipRateViewPresented) {
                                DetailedTipRateView(isActive: self.$isDetailedTipRateViewPresented).environmentObject(self.wCalcModel)
                            }
                            .accessibility(label: Text("Tip Rate: \(nForm.roundForPercentWithTwoDecimalPlaces(self.wCalcModel.tipRate))"))
                            .modifier(scalingEffect())
                        
                    
                    Text("Tip:")
                        .cardStyled(value: self.$wCalcModel.tipAmount, style: .currency, backgroundColor: .secondary)
                        .accessibility(label: Text("Tip Amount: \(nForm.roundForCurrency(number: self.wCalcModel.tipAmount) )"))
                        .modifier(scalingEffect())
                    
                    if (self.wCalcModel.partySize != 1) {
                        Text("Per Person:")
                            .cardStyled(value: self.$wCalcModel.totalAmountPerPerson, style: .currency, backgroundColor: .secondary)
                            .accessibility(label: Text("Tip Amount Per Person: \(nForm.roundForCurrency(number: self.wCalcModel.totalAmountPerPerson) )"))
                            .modifier(scalingEffect())
                    }
                    
                    Text("Total:")
                        .cardStyled(value: self.$wCalcModel.totalAmount, style: .currency, backgroundColor: .secondary)
                        .accessibility(label: Text("Total: \(nForm.roundForCurrency(number: self.wCalcModel.totalAmount) )"))
                        .modifier(scalingEffect())
                    
                    Spacer()
                    
                }
                .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            }
        }
    }
}

struct ValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ValuesView()
            .environmentObject(CalculationsModel())
            .environment(\.sizeCategory, .extraLarge)
    }
}
