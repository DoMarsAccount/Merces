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
            
            Button(action: {
                self.activeField = EditableTextFields.localTax
            }) {
                VStack {
                    Text("Local Sales Tax Rate")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        .scaleEffect(self.activeField == EditableTextFields.localTax ? highlightedScale : 1.0)
                    
                    ThreeDecimalPercentageView(value: self.$userPrefs.localSalesTax).padding(.top)
                }
            }
            .frame(maxHeight: geo.size.height / 3)
            .modifier(AdaptiveCardBackground())
            .accentColor(.primary)
            .accessibility(label: Text("Local Sales Tax: \(nForm.roundForPercentWithTwoDecimalPlaces(self.userPrefs.localSalesTax)))"))
            .accessibility(hint: Text("Updates "))
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
                VStack {
                    Text("Venue: \(self.userPrefs.venueEditor.selectedVenue.name)")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    PPageVenuePicker()
                }.accessibility(label: Text("Venue: \(self.userPrefs.venueEditor.selectedVenue.name)"))
                
                HStack {
                    
                    Button(action: {
                        self.activeField = EditableTextFields.poorTip
                    }) {
                        VStack {
                            HStack {
                                Text("Bad")
                                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                    .scaleEffect(self.activeField == EditableTextFields.poorTip ? highlightedScale : 1.0)
                                ServiceQuality.Bad.image
                            }
                            
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Bad)))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .border(Color.primary, width: 2)
                                .cornerRadius(2)
                                .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                            
                        }
                    }
                    .accentColor(.primary)
                    .accessibility(label: Text("Bad Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Bad)))"))
                    
                    Button(action: {
                        self.activeField = EditableTextFields.averageTip
                    }) {
                        VStack {
                            HStack {
                                Text("Good")
                                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                    .scaleEffect(self.activeField == EditableTextFields.averageTip ? highlightedScale : 1.0)
                                ServiceQuality.Good.image
                            }
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Good)))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .border(Color.primary, width: 2)
                            .cornerRadius(2)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        }
                    }
                    .accentColor(.primary)
                    .accessibility(label: Text("Good Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Good)))"))
                    
                    Button(action: {
                        self.activeField = EditableTextFields.greatTip
                    }) {
                        VStack {
                            HStack {
                                Text("Great")
                                    .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                                    .scaleEffect(self.activeField == EditableTextFields.greatTip ? highlightedScale : 1.0)
                                ServiceQuality.Great.image
                            }
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Great)))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .border(Color.primary, width: 2)
                            .cornerRadius(2)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                        }
                    }
                    .accentColor(.primary)
                    .accessibility(label: Text("Great Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Great)))"))
                    
                }.padding(.top)
            }
            .modifier(AdaptiveCardBackground())
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
