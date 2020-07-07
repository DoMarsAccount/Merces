//
//  ServiceQualityPicker.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ServiceQualityPicker: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes = Themes.sharedInstance
    @ObservedObject var calcModel = CalculationsModel.sharedInstance
    
    var body: some View {
        Picker(selection: self.$calcModel.service, label: Text("Service Quality")) {
            ForEach(0..<ServiceQuality.allCases.count) { index in
                ServiceQuality.allCases[index].image
                    .resizable()
                    .tag(ServiceQuality.allCases[index])
                    .accessibility(label: Text("Service Quality: \(ServiceQuality.allCases[index].name)"))
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isFlat: true)))
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isFlat: true)))
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .scaledToFill()
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .circular))
        .accessibility(label: Text("Service Quality: \(self.calcModel.service.name)"))
    }
}

struct ServiceQualityPickerButtons: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @ObservedObject var themes = Themes.sharedInstance
    @ObservedObject var calcModel = CalculationsModel.sharedInstance
    
    var body: some View {
        HStack {
            
            Button(action: {
                self.calcModel.service = .Bad
            }) {
                VStack {
                    HStack {
                        Text("Bad")
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                        ServiceQuality.Bad.image
                    }
                    
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Bad)))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(2)
                        .font(Font(self.userPrefs.headlineFont(size: 18)))
                    
                }
            }
            .id("\(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Bad)))")
            .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)))
            .accessibility(label: Text("Bad Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Bad)))"))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark))
            
            Button(action: {
                self.calcModel.service = .Good
            }) {
                VStack {
                    HStack {
                        Text("Good")
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                        ServiceQuality.Good.image
                    }
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Good)))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .cornerRadius(2)
                    .font(Font(self.userPrefs.headlineFont(size: 18)))
                }
            }
            .id("\(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Good)))")
            .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)))
            .accessibility(label: Text("Good Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Good)))"))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark))
            
            Button(action: {
                self.calcModel.service = .Great
            }) {
                VStack {
                    HStack {
                        Text("Great")
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                        ServiceQuality.Great.image
                    }
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Great)))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .cornerRadius(2)
                    .font(Font(self.userPrefs.headlineFont(size: 18)))
                }
            }
            .id("\(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Great)))")
            .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)))
            .accessibility(label: Text("Great Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.calcModel.selectedVenue, service: .Great)))"))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark))
            
        }
    }
}

struct ServiceQualityPicker_Previews: PreviewProvider {
    static var previews: some View {
        ServiceQualityPickerButtons()
    }
}
