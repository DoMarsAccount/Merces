//
//  VenuePicker.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct VenuePicker: View {
    @ObservedObject var calcModel = varAmts.calcModel
    var body: some View {
        VStack {
            Picker(selection: self.$calcModel.selectedVenue, label: Text("Venue")) {
                ForEach(1..<VenueType.allCases.count) { index in
                    Text(VenueType.allCases[index].name)
                        .tag(VenueType.allCases[index])
                        .accessibility(value: Text("Venue: \(VenueType.allCases[index].name)"))
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
    }
}

struct PPageVenuePicker: View {
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
        
        var body: some View {
            VStack {
                Picker(selection: self.$venueEditor.selectedVenue, label: Text("Venue")) {
                    ForEach(1..<VenueType.allCases.count) { index in
                        Text(VenueType.allCases[index].emoji)
                            .tag(VenueType.allCases[index])
                            .accessibility(value: Text("Venue: \(VenueType.allCases[index].name)"))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
}

struct VenuePicker_Previews: PreviewProvider {
    static var previews: some View {
        PPageVenuePicker()
//        Text("\u{1F355}")
    }
}
