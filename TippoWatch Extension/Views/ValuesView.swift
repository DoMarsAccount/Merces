//
//  ValuesView.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI



struct ValuesView: View {
    @EnvironmentObject var userPrefs: UserPreferences
    @EnvironmentObject var wCalcModel: CalculationsModel
    @State private var isSubtotalKeypadPresented: Bool = false
    @State private var isTaxAmountKeypadPresented: Bool = false
    @State private var isPartySizeKeypadPresented: Bool = false
    @State private var isTipRateKeypadPresented: Bool = false
    @State private var isDetailedTipRateViewPresented: Bool = false
    @State private var isSettingsPageActive: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
//                    HStack {
                    Text("Subtotal")
                        .cardStyled(value: self.$wCalcModel.subtotal, style: .currency, backgroundColor: Color("CrayolaRed"))
                        .onTapGesture {
                            self.isSubtotalKeypadPresented.toggle()
                        }
                        .sheet(isPresented: self.$isSubtotalKeypadPresented) {
                            Keypad(value: self.$wCalcModel.subtotal, isPresented: self.$isSubtotalKeypadPresented, activeField: .constant(.subtotal))
                        }
                        .accessibility(label: Text("Subtotal: \(nForm.roundForCurrency(number: self.wCalcModel.subtotal) )"))
                        .modifier(scalingEffect())
                    
                HStack {
                    if !self.userPrefs.subtotalIsPostTax {
                    Text("Sales Tax")
                        .vCardStyled(value: self.$wCalcModel.taxAmount, style: .currency, backgroundColor: Color("CrayolaRed"))
                        .onTapGesture {
                            self.isTaxAmountKeypadPresented.toggle()
                        }
                        .sheet(isPresented: self.$isTaxAmountKeypadPresented) {
                            Keypad(value: self.$wCalcModel.taxAmount, isPresented: self.$isTaxAmountKeypadPresented, activeField: .constant(.salesTax))
                        }
                    .accessibility(label: Text("Sales Tax: \(nForm.roundForCurrency(number: self.wCalcModel.taxAmount) )"))
                    .modifier(scalingEffect())
                    
                    Text("Party of")
                        .vCardStyled(value: self.$wCalcModel.partySize.double, style: .integer, backgroundColor: Color("CrayolaRed"))
                        .onTapGesture {
                            self.isPartySizeKeypadPresented.toggle()
                        }
                        .sheet(isPresented: self.$isPartySizeKeypadPresented) {
                            Keypad(value: self.$wCalcModel.partySize.double, isPresented: self.$isPartySizeKeypadPresented, activeField: .constant(.partySize))
                        }
                        .accessibility(label: Text("Party Size: \(nForm.formatIntegerNumbers(self.wCalcModel.partySize))"))
                        .modifier(scalingEffect())
                    } else {
                        Text("Party Size")
                        .cardStyled(value: self.$wCalcModel.partySize.double, style: .integer, backgroundColor: Color("CrayolaRed"))
                        .onTapGesture {
                            self.isPartySizeKeypadPresented.toggle()
                        }
                        .sheet(isPresented: self.$isPartySizeKeypadPresented) {
                            Keypad(value: self.$wCalcModel.partySize.double, isPresented: self.$isPartySizeKeypadPresented, activeField: .constant(.partySize))
                        }
                        .accessibility(label: Text("Party Size: \(nForm.formatIntegerNumbers(self.wCalcModel.partySize))"))
                        .modifier(scalingEffect())
                    }
                }
            
//                    HStack {
                    Text("Tip %")
                        .cardStyled(value: self.$wCalcModel.tipRate, style: .percentage, backgroundColor: Color("CrayolaRed"))
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
                
                Divider()
                
                NavigationLink(destination: SettingsPage().environmentObject(self.userPrefs), isActive: self.$isSettingsPageActive) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings").font(.headline)
                        Spacer()
                    }
                }
                .modifier(scalingEffect())
                
                Button(action: {
                    self.wCalcModel.resetValues()
                }) {
                    HStack {
                        Image(systemName: "xmark")
                        Text("Clear Values").font(.headline)
                        Spacer()
                    }
                }
                .modifier(scalingEffect())
                
            }
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        }
        
    }
}

struct ValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ValuesView()
            .environmentObject(CalculationsModel.sharedInstance)
            .environmentObject(UserPreferences.sharedInstance)
            .environment(\.sizeCategory, .extraLarge)
    }
}
