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
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    VStack {
                        Text("Tip %").font(.headline)
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(currentTipRate(for: self.wCalcModel.selectedVenue, service: self.wCalcModel.service)))
                    }
                    .padding()
                    .frame(width: geo.size.width / 2, height: viewHeight)
                    .background(Color.purple)
                    .border(Color.purple, width: 2.5)
                    .cornerRadius(2.5)
                    .onTapGesture {
                        self.presentKeypad.toggle()
                    }
                    .sheet(isPresented: self.$presentKeypad) {
                        WatchKeypad(value: self.$wCalcModel.tipRate, isPresented: self.$presentKeypad, activeField: .constant(.tipRate))
                    }.navigationBarTitle("Done")
                    
                    Picker(selection: self.$wCalcModel.service, label: Text("Service Level")
                            .font(.headline)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.8)
                    ){
                        ForEach(0..<ServiceQuality.allCases.count) { index in
                            HStack {
                                Text(ServiceQuality.allCases[index].name).tag(ServiceQuality.allCases[index])
                                ServiceQuality.allCases[index].image
                            }
                        }
                    }.frame(height: viewHeight)
                    
                    Picker(selection: self.$wCalcModel.selectedVenue, label: Text("Venue").font(.headline)) {
                        ForEach(0..<VenueType.allCases.count) { index in
                            Text(VenueType.allCases[index].name).tag(VenueType.allCases[index])
                        }
                    }.frame(height: viewHeight)
                }
            }
        }
    }
}

struct DetailedTipRateView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedTipRateView(isActive: .constant(true)).environmentObject(varAmts.calcModel)
    }
}
