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
        GeometryReader { geo in
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
            .padding()
            .frame(width: geo.size.width, height: geo.size.height)
            .border(Color.primary, width: 2)
            .cornerRadius(2)
        }
    }
}

struct PPageVenuePicker: View {
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
        
        var body: some View {
            VStack {
                Picker("Venue", selection: self.$venueEditor.selectedVenue) {
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

struct VenueView: View {
    @ObservedObject var calcModel = varAmts.calcModel
    var venue: VenueType
    @Binding var activeField: EditableTextFields
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(self.venue.emoji)
//                    .padding()
                Text(self.venue.name)
                    .padding(.top)
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.white)
            .border(Color.primary, width: 4)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .onTapGesture {
                self.calcModel.selectedVenue = self.venue
                self.activeField = .none
            }
        }
    }
}

struct VenueSelectionView: View {
    @ObservedObject var calcModel = varAmts.calcModel
    @Binding var activeField: EditableTextFields
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    VenueView(venue: .bar, activeField: self.$activeField)
                    VenueView(venue: .quick, activeField: self.$activeField)
                    VenueView(venue: .dining, activeField: self.$activeField)
                }
                
                HStack {
                    VenueView(venue: .taxi, activeField: self.$activeField)
                    VenueView(venue: .salon, activeField: self.$activeField)
                    VenueView(venue: .delivery, activeField: self.$activeField)
                }
            }
            .modifier(AdaptiveViewBackground(backgroundColor: Color(coloringThemes.mainColor)))
        }
    }
}

struct VenuePicker_Previews: PreviewProvider {
    static var previews: some View {
//        VenuePicker()
        VenueSelectionView(activeField: .constant(.none))
//        PPageVenuePicker()
    }
}
