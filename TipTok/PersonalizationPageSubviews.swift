//
//  PersonalizationPageSubviews.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ThreeDecimalPercentageView: View {
    @Binding var value: Double
    var body: some View {
        Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .border(Color.primary, width: 2)
            .cornerRadius(2)
            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
    }
}

struct PPageTopView: View {
    @Binding var activeField: EditableTextFields
    @EnvironmentObject var userPrefs: UserPreferences
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Local Sales Tax Rate")
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    .scaleEffect(self.activeField == EditableTextFields.localTax ? highlightedScale : 1.0)
                
                ThreeDecimalPercentageView(value: self.$userPrefs.localSalesTax).padding(.top)
            }.onTapGesture {
                self.activeField = EditableTextFields.localTax
            }
            .padding()
            .frame(width: geo.size.width, height: geo.size.height)
            .border(Color.primary, width: 2)
            .cornerRadius(2)
        }
    }
}

struct PPageMiddleView: View {
    @Binding var activeField: EditableTextFields
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Venue: \(self.userPrefs.venueEditor.selectedVenue.name)")
                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                PPageVenuePicker()
                
                HStack {
                    VStack {
                        HStack {
                            Text("Bad")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                .scaleEffect(self.activeField == EditableTextFields.poorTip ? highlightedScale : 1.0)
                            ServiceQuality.Bad.image
                        }
                        
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(currentTipRate(for: self.venueEditor.selectedVenue, service: .Bad)))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .border(Color.primary, width: 2)
                            .cornerRadius(2)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        
                    }.onTapGesture {
                        self.activeField = EditableTextFields.poorTip
                    }
                    
                    VStack {
                        HStack {
                            Text("Good")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                .scaleEffect(self.activeField == EditableTextFields.averageTip ? highlightedScale : 1.0)
                            ServiceQuality.Good.image
                        }
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(currentTipRate(for: self.venueEditor.selectedVenue, service: .Good)))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .border(Color.primary, width: 2)
                        .cornerRadius(2)
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }.onTapGesture {
                        self.activeField = EditableTextFields.averageTip
                    }
                    
                    VStack {
                        HStack {
                            Text("Great")
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                .scaleEffect(self.activeField == EditableTextFields.greatTip ? highlightedScale : 1.0)
                            ServiceQuality.Great.image
                        }
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(currentTipRate(for: self.venueEditor.selectedVenue, service: .Great)))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .border(Color.primary, width: 2)
                        .cornerRadius(2)
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }.onTapGesture {
                        self.activeField = EditableTextFields.greatTip
                    }
                }.padding(.top)
            }
            .padding()
            .frame(width: geo.size.width, height: geo.size.height)
            .border(Color.primary, width: 2)
            .cornerRadius(2)
        }
    }
}

struct PPageBottomView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
            }
            .padding()
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}
