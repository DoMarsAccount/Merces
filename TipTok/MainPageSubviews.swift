//
//  MainPageSubviews.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

let highlightedScale: CGFloat = 1.3

struct MainPageTopSubview: View {
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @Binding var activeField: EditableTextFields
    var body: some View {
        VStack {
            Button(action: {
                self.activeField = EditableTextFields.subtotal
            }) {
                VStack {
                    Text("Subtotal")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        .scaleEffect(self.activeField == EditableTextFields.subtotal ? highlightedScale : 1.0)
                        .minimumScaleFactor(0.75)
                    CurrencyView(value: self.$calcModel.subtotal)
                }
            }
            .accentColor(.primary)
            .accessibility(label: Text("Subtotal \(nForm.roundForCurrency(number: self.calcModel.subtotal))"))
            
            
            HStack {
                if !UserPreferences.sharedInstance.subtotalIsPostTax {
                    Button(action: {
                        if self.userPrefs.localSalesTax == 0.0 {
                            self.activeField = EditableTextFields.salesTax
                        }
                    }) {
                        VStack {
                            Text("Sales Tax")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                .scaleEffect(self.activeField == EditableTextFields.salesTax ? highlightedScale : 1.0)
                                .minimumScaleFactor(0.75)
                            CurrencyView(value: self.$calcModel.taxAmount, isEnabled: self.userPrefs.localSalesTax == 0.0)
                        }
                    }
                    .accentColor(.primary)
                    .accessibility(label: Text("Sales Tax \(nForm.roundForCurrency(number: self.calcModel.taxAmount))"))
                
                    Button(action: {
                        self.activeField = EditableTextFields.partySize
                    }) {
                        VStack {
                            Text("Party Size")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                .scaleEffect(self.activeField == EditableTextFields.partySize ? highlightedScale : 1.0)
                                .minimumScaleFactor(0.75)
                            IntegerView(value: self.$calcModel.partySize)
                        }
                    }
                    .accentColor(.primary)
                    .accessibility(label: Text("Party Size:  \(nForm.formatIntegerNumbers(self.calcModel.partySize))"))
                } else {
                    Button(action: {
                        self.activeField = EditableTextFields.partySize
                    }) {
                        HStack {
                            Text("Party Size")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                .scaleEffect(self.activeField == EditableTextFields.partySize ? highlightedScale : 1.0)
                                .minimumScaleFactor(0.75)
                                .padding()
                            IntegerView(value: self.$calcModel.partySize)
                        }.padding(.vertical )
                    }
                    .accentColor(.primary)
                    .accessibility(label: Text("Party Size:  \(nForm.formatIntegerNumbers(self.calcModel.partySize))"))
                }
            }
//                .padding(.top)
        }
        .modifier(AdaptiveCardBackground())
    }
}

struct MainPageMiddleSubview: View {
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    @Binding var activeField: EditableTextFields
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    
                    Button(action: {
                        self.activeField = EditableTextFields.venue
                    }) {
                        VStack {
                            Text("Venue")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                            
                            ZStack {
                                Color.black
                                    .opacity(0.0)
                                Text(self.calcModel.selectedVenue.name)
                                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                            }
                            .frame(maxHeight: geo.size.height / 3)
                            .modifier(MercesStyleTextField())
                        }
                    }
                    .accentColor(.primary)
                    .accessibility(label: Text("Venue: \(self.calcModel.selectedVenue.name)"))
                    
                    Button(action: {
                        self.activeField = EditableTextFields.tipRate
                    }) {
                        VStack {
                            Text("Tip %")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                .scaleEffect(self.activeField == EditableTextFields.tipRate ? highlightedScale : 1.0)
                            PercentageView(value: self.$calcModel.tipRate)
                                .frame(maxHeight: geo.size.height / 3)
                        }
                    }
                    .accentColor(.primary)
                    .accessibility(label: Text("Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(self.calcModel.tipRate))"))
                }
                
                VStack {
                    Text("Service Level")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    ServiceQualityPicker()
                }.accessibility(label: Text("Service Level: \(self.calcModel.service.name)"))
    //            .padding(.top)
            }
            .modifier(AdaptiveCardBackground())
        }
    }
}

struct MainPageBottomSubview: View {
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack(alignment: .center) {
                    Text("Totaled Amounts")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        .minimumScaleFactor(0.5)
                }
                
                if self.calcModel.tipAmount != 0.0 {
                    HStack {
                        Text("Tip Amount:")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        CurrencyView(value: self.$calcModel.tipAmount, isEnabled: false)
                    }
                    .frame(maxHeight: geo.size.height / 3)
                    .accessibility(label: Text("Tip Amount: \(nForm.roundForCurrency(number: self.calcModel.tipAmount))"))
    //                .padding(.top)
                }
                
                HStack {
                    Text("Grand Total:")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    CurrencyView(value: self.$calcModel.totalAmount, isEnabled: false)
                }
                .frame(maxHeight: geo.size.height / 3)
                .accessibility(label: Text("Grand Total: \(nForm.roundForCurrency(number: self.calcModel.totalAmount))"))
    //                .padding(.top)
                
                if self.calcModel.partySize != 1 {
                    HStack {
                        Text("Each Person:")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        CurrencyView(value: self.$calcModel.totalAmountPerPerson, isEnabled: false)
                    }
                    .frame(maxHeight: geo.size.height / 3)
                    .accessibility(label: Text("Total Per Person: \(nForm.roundForCurrency(number: self.calcModel.totalAmountPerPerson))"))
    //                    .padding(.top)
                }
            }
//            .frame(maxHeight: geo.size.height / 4)
            .modifier(AdaptiveCardBackground())
        }
    }
}

struct MainPageSubviews_Previews: PreviewProvider {
    static var previews: some View {
        MainPageTopSubview(activeField: .constant(.none))
    }
}
