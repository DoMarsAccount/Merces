//
//  VenuesView.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/10/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct VenuesView: View {
    @EnvironmentObject var wCalcModel: CalculationsModel
    @State private var isActive: Bool = false {
        didSet {
            venueEditor.resetTipAmount()
        }
    }
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
    
    var body: some View {
        VStack {
            
            HStack {
                Picker(selection: self.$venueEditor.service, label: Text("Service Level")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.8)
                        .accessibility(label: Text("Service Level: \(self.venueEditor.service.name)"))
                ){
                    ForEach(0..<ServiceQuality.allCases.count) { index in
                        HStack {
                            Text(ServiceQuality.allCases[index].name)
                            ServiceQuality.allCases[index].image
                        }
                        .tag(ServiceQuality.allCases[index])
                        .accessibility(value: Text("Service Level: \(ServiceQuality.allCases[index].name)"))
                    }
                }.frame(height: viewHeight)
                
                VStack {
                    Text("Tip %").font(.headline)
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(currentTipRate(for: self.venueEditor.selectedVenue, service: self.venueEditor.service)))
                }
                .padding([.leading, .trailing])
                .frame(height: viewHeight)
                .background(Color.red)
                .border(Color.red, width: 2.5)
                .cornerRadius(2.5)
                .onTapGesture {
                    self.isActive.toggle()
                }
                .sheet(isPresented: self.$isActive) {
                    WatchKeypad(value: self.$venueEditor.tipAmount, isPresented: self.$isActive, activeField: self.$venueEditor.activeField)
                }.navigationBarTitle("Done")
                .accessibility(label: Text("Tip Rate \(nForm.roundForPercentWithTwoDecimalPlaces(currentTipRate(for: self.venueEditor.selectedVenue, service: self.venueEditor.service)))"))
                
            }
            
            Picker(selection: self.$venueEditor.selectedVenue, label: Text("Venue").font(.headline)
                .accessibility(label: Text("Venue: \(self.venueEditor.selectedVenue.name)"))
            ) {
                ForEach(1..<VenueType.allCases.count) { index in
                    Text(VenueType.allCases[index].name).tag(VenueType.allCases[index])
                        .accessibility(label: Text("Venue: \(VenueType.allCases[index].name)"))
                }
            }.frame(height: viewHeight)
        
        }
    }
}

struct VenuesView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesView().environmentObject(varAmts.calcModel)
    }
}
