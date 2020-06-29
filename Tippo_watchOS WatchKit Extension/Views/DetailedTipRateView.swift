//
//  DetailedTipRateView.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/11/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct DetailedTipRateView: View {
    @EnvironmentObject var wCalcModel: CalculationsModel
    @Binding var isActive: Bool
    @State private var presentKeypad: Bool = false
    
    var body: some View {
//        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    TipRateField(presentKeypad: self.$presentKeypad)
                    
                    Picker(selection: self.$wCalcModel.selectedVenue, label: Text("Venue").font(.headline)) {
                        ForEach(1..<VenueType.allCases.count) { index in
                            Text(VenueType.allCases[index].name).tag(VenueType.allCases[index])
                        }
                    }.frame(height: viewHeight)
                    
                    ServiceQualityPicker()
                }.navigationBarTitle("Done")
            }
//        }
    }
}

struct DetailedTipRateView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedTipRateView(isActive: .constant(true)).environmentObject(CalculationsModel.sharedInstance)
    }
}

struct ServiceQualityPicker: View {
    @EnvironmentObject var wCalcModel: CalculationsModel
    var body: some View {
        HStack {
            Button(action: {
                self.wCalcModel.service = .Bad
            }) {
                VStack {
                    ServiceQuality.Bad.image
                    Text(ServiceQuality.Bad.name)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }.foregroundColor(self.wCalcModel.service == .Bad ? .white : Color("OuterSpace"))
            
            Button(action: {
                self.wCalcModel.service = .Good
            }) {
                VStack {
                    ServiceQuality.Good.image
                    Text(ServiceQuality.Good.name)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }.foregroundColor(self.wCalcModel.service == .Good ? .white : Color("OuterSpace"))
            
            Button(action: {
                self.wCalcModel.service = .Great
            }) {
                VStack {
                    ServiceQuality.Great.image
                    Text(ServiceQuality.Great.name)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }.foregroundColor(self.wCalcModel.service == .Great ? .white : Color("OuterSpace"))
        }
        
//        Picker(selection: self.$wCalcModel.service, label: Text("Service Quality")
//            .font(.headline)
//            .multilineTextAlignment(.leading)
//            .minimumScaleFactor(0.8)
//        ){
//            ForEach(0..<ServiceQuality.allCases.count) { index in
//                HStack {
//                    Text(ServiceQuality.allCases[index].name)
//                    ServiceQuality.allCases[index].image
//                }
//            }
//        }.frame(height: viewHeight)
    }
}

struct TipRateField: View {
    @Binding var presentKeypad: Bool
    @EnvironmentObject var wCalcModel: CalculationsModel
    var body: some View {
        HStack {
            Text("Tip %")
                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
                .padding()
                .minimumScaleFactor(0.3)
            
            Spacer()
            Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.wCalcModel.selectedVenue, service: self.wCalcModel.service)))
                .padding()
                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: title3TextSize)))
                .minimumScaleFactor(0.8)
        }
            //                    .frame(width: .infinity)
            //                    .frame(height: viewHeight)
            .background(Color("CrayolaRed"))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
            .onTapGesture {
                self.presentKeypad.toggle()
            }
            .sheet(isPresented: self.$presentKeypad) {
                Keypad(value: self.$wCalcModel.tipRate, isPresented: self.$presentKeypad, activeField: .constant(.tipRate))
            }
    }
}
