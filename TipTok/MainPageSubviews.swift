//
//  MainPageSubviews.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

let highlightedScale: CGFloat = 1.3

struct CurrencyView: View {
    @Binding var value: Double
    var body: some View {
        Text(nForm.roundForCurrency(number: self.value))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .border(Color.primary, width: 2)
            .cornerRadius(2)
            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
    }
}

struct IntegerView: View {
    @Binding var value: Int
    var body: some View {
        Text(nForm.formatIntegerNumbers(self.value))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .border(Color.primary, width: 2)
            .cornerRadius(2)
            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
    }
}

struct PercentageView: View {
    @Binding var value: Double
    var body: some View {
        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .border(Color.primary, width: 2)
            .cornerRadius(2)
            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
    }
}

struct MainPageTopSubview: View {
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    @Binding var activeField: EditableTextFields
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    Text("Subtotal")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        .scaleEffect(self.activeField == EditableTextFields.subtotal ? highlightedScale : 1.0)
                    CurrencyView(value: self.$calcModel.subtotal)
                }.onTapGesture {
                    self.activeField = EditableTextFields.subtotal
                }
                
                HStack {
                    VStack {
                        Text("Sales Tax")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                            .scaleEffect(self.activeField == EditableTextFields.salesTax ? highlightedScale : 1.0)
                        CurrencyView(value: self.$calcModel.taxAmount)
                    }.onTapGesture {
                        self.activeField = EditableTextFields.salesTax
                    }
                    
                    VStack {
                        Text("Party of")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                            .scaleEffect(self.activeField == EditableTextFields.partySize ? highlightedScale : 1.0)
                        IntegerView(value: self.$calcModel.partySize)
                    }.onTapGesture {
                        self.activeField = EditableTextFields.partySize
                    }
                }.padding(.top)
            }
            .padding()
            .frame(width: geo.size.width, height: geo.size.height)
            .border(Color.primary, width: 2)
            .cornerRadius(2)
        }
    }
}

struct MainPageMiddleSubview: View {
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    @Binding var activeField: EditableTextFields
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    VStack {
                        Text("Venue")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                            
//                        VenuePicker()
                        
                        Text(self.calcModel.selectedVenue.name)
                            .padding()
                            .border(Color.primary, width: 2)
                            .cornerRadius(2)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }
                    
                    VStack {
                        Text("Tip %")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                            .scaleEffect(self.activeField == EditableTextFields.tipRate ? highlightedScale : 1.0)
                        PercentageView(value: self.$calcModel.tipRate)
                    }.onTapGesture {
                        self.activeField = EditableTextFields.tipRate
                    }
                }
                
                VStack {
                    Text("Service Level")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    ServiceQualityPicker()
                }.padding(.top)
            }
            .padding()
            .frame(width: geo.size.width, height: geo.size.height)
            .border(Color.primary, width: 2)
            .cornerRadius(2)
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
                }
                if self.calcModel.tipAmount != 0.0 {
                    HStack {
                        Text("Tip Amount:")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        CurrencyView(value: self.$calcModel.tipAmount)
                    }
    //                .padding(.top)
                }
                
                HStack {
                    Text("Grand Total:")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    CurrencyView(value: self.$calcModel.totalAmount)
                }
//                .padding(.top)
                
                if self.calcModel.partySize != 1 {
                    HStack {
                        Text("Each Person:")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        CurrencyView(value: self.$calcModel.totalAmountPerPerson)
                    }
//                    .padding(.top)
                }
            }
            .padding()
            .frame(width: geo.size.width, height: geo.size.height)
            .border(Color.primary, width: 2)
            .cornerRadius(2)
        }
    }
}

struct MainPageSubviews_Previews: PreviewProvider {
    static var previews: some View {
        MainPageTopSubview(activeField: .constant(.none))
    }
}
