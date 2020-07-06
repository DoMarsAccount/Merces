//
//  PersonalizationPageSubviews.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ThreeDecimalPercentageView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @Binding var value: Double
    var body: some View {
        Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)), width: 2)
            .cornerRadius(2)
            .font(Font(self.userPrefs.headlineFont(size: 18)))
    }
}

struct PPageTopView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @EnvironmentObject var userPrefs: UserPreferences
    
    var body: some View {
        GeometryReader { geo in
            
            Button(action: {
                self.inputs.activeField = EditableTextFields.localTax
            }) {
                VStack {
                    Text("Local Sales Tax Rate")
                        .font(Font(self.userPrefs.headlineFont(size: 18)))
                        .scaleEffect(self.inputs.activeField == EditableTextFields.localTax ? highlightedScale : 1.0)
                    
                    ThreeDecimalPercentageView(value: self.$userPrefs.localSalesTax).padding(.top)
                }
            }
            .frame(maxHeight: geo.size.height / 3)
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isInputCard: false))
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)))
            .accessibility(label: Text("Local Sales Tax: \(nForm.roundForPercentWithTwoDecimalPlaces(self.userPrefs.localSalesTax)))"))
        }
    }
}

struct PPageMiddle: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
    
    var body: some View {
        HStack {
            
            Button(action: {
                self.inputs.activeField = EditableTextFields.badTip
            }) {
                VStack {
                    HStack {
                        Text("Bad")
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                            .scaleEffect(self.inputs.activeField == EditableTextFields.badTip ? highlightedScale : 1.0)
                        ServiceQuality.Bad.image
                    }
                    
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Bad)))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(2)
                        .font(Font(self.userPrefs.headlineFont(size: 18)))
                    
                }
            }
            .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)))
            .accessibility(label: Text("Bad Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Bad)))"))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark))
            
            Button(action: {
                self.inputs.activeField = EditableTextFields.goodTip
            }) {
                VStack {
                    HStack {
                        Text("Good")
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                            .scaleEffect(self.inputs.activeField == EditableTextFields.goodTip ? highlightedScale : 1.0)
                        ServiceQuality.Good.image
                    }
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Good)))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .cornerRadius(2)
                    .font(Font(self.userPrefs.headlineFont(size: 18)))
                }
            }
            .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)))
            .accessibility(label: Text("Good Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Good)))"))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark))
            
            Button(action: {
                self.inputs.activeField = EditableTextFields.greatTip
            }) {
                VStack {
                    HStack {
                        Text("Great")
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                            .scaleEffect(self.inputs.activeField == EditableTextFields.greatTip ? highlightedScale : 1.0)
                        ServiceQuality.Great.image
                    }
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Great)))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .cornerRadius(2)
                    .font(Font(self.userPrefs.headlineFont(size: 18)))
                }
            }
            .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)))
            .accessibility(label: Text("Great Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venueEditor.selectedVenue, service: .Great)))"))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark))
            
        }
    }
}

struct PPageMiddleView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
    
    var body: some View {
        VStack {
            PPageVenueSelection()
            
            PPageMiddle()
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


struct PersonalizationPageSubviews_Previews: PreviewProvider {
    static var previews: some View {
        PPageMiddle()
    }
}

struct PPageVenueSelection: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
    
    var body: some View {
        VStack {
            Text("Venue: \(self.userPrefs.venueEditor.selectedVenue.name)")
                .font(Font(self.userPrefs.headlineFont(size: 18)))
            PPageVenuePicker()
        }
        .accessibility(label: Text("Venue: \(self.userPrefs.venueEditor.selectedVenue.name)"))
        .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)))
        .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isInputCard: false))
        
    }
}
