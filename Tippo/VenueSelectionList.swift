//
//  VenueSelectionList.swift
//  Tippo
//
//  Created by Donovan McCray on 6/29/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct VenueSelectionList: View {
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var venues = Venues.sharedInstance
    @State private var addVenueSheetPresented: Bool = false
    @Binding var selectedVenue: Venue
    
    var body: some View {
        List {
            ForEach(venues.venues, id: \.self) { venue in
                HStack {
                    VStack(alignment: .leading) {
                        Text(venue.name.capitalized)
                            .font(Font(self.userPrefs.headlineFont(size: 24)))
                            .bold()
                        
                        Text("(\(nForm.roundForPercentWithTwoDecimalPlaces(venue.tipAmounts[0])), \(nForm.roundForPercentWithTwoDecimalPlaces(venue.tipAmounts[1])), \(nForm.roundForPercentWithTwoDecimalPlaces(venue.tipAmounts[2])))")
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                    }
                    Spacer()
                    Image(systemName: venue.isDefaultVenue ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.venues.updateDefaultVenue(newVenue: venue.name)
                        }
                }
                .onTapGesture {
                    self.selectedVenue = venue
                }
            }
            .onDelete(perform: venues.deleteVenue(at:))
        }
    }
    
    private func addNewVenue() {
        self.addVenueSheetPresented = true
    }
}

struct VenueSelectionList_Previews: PreviewProvider {
    static var previews: some View {
        VenueSelectionList(selectedVenue: .constant(Venue(name: "None", tipAmounts: [0.0, 0.0, 0.0]))).environmentObject(UserPreferences.sharedInstance)
    }
}
