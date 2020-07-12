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
    @ObservedObject var venueEditor = VenueEditor.sharedInstance
    @ObservedObject var venues = Venues.sharedInstance
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Tip %").font(.headline)
                Spacer()
                Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venues.selectedVenue, service: self.venueEditor.service)))
            }
                .padding([.leading, .trailing])
                .frame(height: viewHeight)
                .frame(maxWidth: .infinity)
                .background(Color("CrayolaRed"))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                .onTapGesture {
                    self.isActive.toggle()
                }
                .sheet(isPresented: self.$isActive) {
                    Keypad(value: self.$venueEditor.tipAmount, isPresented: self.$isActive, activeField: self.$venueEditor.activeField)
                }
                .accessibility(label: Text("Tip Rate \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venues.selectedVenue, service: self.venueEditor.service)))"))
            
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
            
            Picker(selection: self.$venues.selectedVenue, label: Text("Venue").font(.headline)
                .accessibility(label: Text("Venue: \(self.venues.selectedVenue.name)"))
            ) {
                ForEach(self.venues.venues, id: \.self) { venue in
                    Text(venue.name.capitalized).tag(venue.name)
                        .accessibility(label: Text("Venue: \(venue.name)"))
                }
            }
            .frame(height: viewHeight)
            .padding(.horizontal)
        }
    }
}

struct VenuesView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesView().environmentObject(CalculationsModel.sharedInstance)
    }
}
