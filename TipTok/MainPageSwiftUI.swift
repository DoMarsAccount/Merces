//
//  MainPageSwiftUI.swift
//  TipTok
//
//  Created by Donovan McCray on 6/14/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

let viewHeight: CGFloat = 200

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
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    Text("Subtotal")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    CurrencyView(value: self.$calcModel.subtotal)
                    
                }
                .padding()
                
                HStack {
                    VStack {
                        Text("Sales Tax")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        CurrencyView(value: self.$calcModel.taxAmount)
                    }
                    .padding(.leading)
                    
                    VStack {
                        Text("Party of")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        IntegerView(value: self.$calcModel.partySize)
                    }.padding(.trailing)
                }
            }
            .frame(width: geo.size.width, height: viewHeight)
            .border(Color.primary, width: 2)
            .cornerRadius(2)
        }
    }
}

struct MainPageMiddleSubview: View {
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    VStack {
                        Text("Venue")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        
                        Text(self.calcModel.selectedVenue.name)
                            .padding()
                            .border(Color.primary, width: 2)
                            .cornerRadius(2)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
    //                    VenuePicker()
                    }.padding(.leading)
                    
                    VStack {
                        Text("Tip %")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        PercentageView(value: self.$calcModel.tipRate)
                    }.padding(.trailing)
                }
                
                VStack {
                    Text("Service Level")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    ServiceQualityPicker()
                }.padding()
            }
            .frame(width: geo.size.width, height: viewHeight)
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
                
                HStack {
                    Text("Tip Amount:")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    CurrencyView(value: self.$calcModel.tipAmount)
                }
                .padding()
                
                if self.calcModel.partySize != 1 {
                    HStack {
                        Text("Total (per person):")
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        CurrencyView(value: self.$calcModel.totalAmountPerPerson)
                    }
                    .padding()
                }
                
                HStack {
                    Text("Grand Total:")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    CurrencyView(value: self.$calcModel.totalAmount)
                }
                .padding()
            }
            .frame(width: geo.size.width, height: viewHeight)
            .border(Color.primary, width: 2)
            .cornerRadius(2)
        }
    }
}

struct MainPageSwiftUI: View {
    @State private var isSettingsActive: Bool = false
    @EnvironmentObject var userPrefs: UserPreferences
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
//                Spacer()
                MainPageTopSubview()
                MainPageMiddleSubview()
                MainPageBottomSubview()
            }
            .padding()
            .navigationBarTitle(Text("TipTok").font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                , displayMode: .inline)
            
            .navigationBarItems(trailing: NavigationLink(destination: Settings(), isActive: self.$isSettingsActive) {
                Image(systemName: "gear")
                    .resizable()
                    .accentColor(.primary)
                    .frame(width: 30, height: 30)
                    .accessibility(label: Text("Settings"))
            })
        }
    }
}

struct MainPageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        MainPageSwiftUI().environmentObject(UserPreferences.sharedInstance)
//        MainPageTopSubview()
    }
}
