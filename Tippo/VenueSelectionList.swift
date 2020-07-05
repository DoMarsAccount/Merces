//
//  VenueSelectionList.swift
//  Tippo
//
//  Created by Donovan McCray on 6/29/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI



struct VenueSelectionList: View {
    @ObservedObject var venues = Venues.sharedInstance
    @State private var addVenueSheetPresented: Bool = false
    var body: some View {
//        NavigationView {
            List {
                ForEach(venues.venues, id: \.self) { venue in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(venue.name.capitalized)
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 24)))
                                .bold()
                            
                            Text("(\(nForm.roundForPercentWithTwoDecimalPlaces(venue.tipAmounts[0])), \(nForm.roundForPercentWithTwoDecimalPlaces(venue.tipAmounts[1])), \(nForm.roundForPercentWithTwoDecimalPlaces(venue.tipAmounts[2])))")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
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
                }
                .onDelete(perform: venues.deleteVenue(at:))
                
            }
            .navigationBarTitle(Text("Venues"))
            .navigationBarItems(trailing: Button(action: {
                self.addNewVenue()
            }) {
                Image(systemName: "plus")
                    .resizable()
                }).accessibility(label: Text("Add a new venue"))
//        }
        .sheet(isPresented: self.$addVenueSheetPresented) {
            AddVenuePage(isUserCreatingVenue: self.$addVenueSheetPresented)
        }
    }
    
    private func addNewVenue() {
        self.addVenueSheetPresented = true
    }
}

struct VenueSelectionList_Previews: PreviewProvider {
    static var previews: some View {
        VenueSelectionList()
    }
}
