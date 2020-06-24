//
//  VenuePicker.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct VenuePicker: View {
    @Environment(\.colorScheme) var colorScheme
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
            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)), width: 2)
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
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var calcModel = varAmts.calcModel
    var venue: VenueType
    @Binding var activeField: EditableTextFields
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if self.colorScheme == .dark {
                    Color("Eerie")
                        .opacity(0.75)
                } else {
                    Color.white
                        .opacity(0.75)
                }
                
                VStack {
                    Text(self.venue.emoji)
    //                    .padding()
                    Text(self.venue.name)
                        .padding(.top)
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        .foregroundColor(self.calcModel.selectedVenue == self.venue ? Color.green : Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)))
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .border(self.calcModel.selectedVenue == self.venue ? Color.green : Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)), width: 4)
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
    @ObservedObject var themes = Themes.sharedInstance
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
            .modifier(AdaptiveCardBackground(backgroundColor: self.themes.mainColor))
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
