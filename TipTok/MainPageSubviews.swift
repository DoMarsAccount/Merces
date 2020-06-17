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
            .modifier(TTCardModifier())
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
                        
                        Text(self.calcModel.selectedVenue.name)
                        .modifier(TextFieldViewModifier())
                    }.onTapGesture {
                        self.activeField = EditableTextFields.venue
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
                
                VStack(spacing: 0) {
                    Text("Service Level")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    ServiceQualityPicker()
                }.padding(.top)
            }
            .modifier(TTCardModifier())
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
            .modifier(TTCardModifier())
        }
    }
}

struct MainPageSubviews_Previews: PreviewProvider {
    static var previews: some View {
        MainPageTopSubview(activeField: .constant(.none))
    }
}
