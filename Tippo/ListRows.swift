//
//  ListRows.swift
//  Tippo
//
//  Created by Donovan McCray on 7/6/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

fileprivate let contentScaleFactor: CGFloat = 1.0
fileprivate let titleScaleFactor: CGFloat = 1.0

struct ListInputRow: View {
    @Binding var value: Double
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @EnvironmentObject var userPrefs: UserPreferences
    var inputStyle: InputStyles
    var title: String
    var field: EditableTextFields
    var background: UIColor = .white
    
    var body: some View {
        Button(action: {
            self.inputs.activeField = self.field
            if !self.userPrefs.reduceHaptics { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
        }) {
            ZStack {
                
                HStack {
                    Text(self.title)
                        .font(Font(self.userPrefs.headlineFont(size: 24)))
                        .minimumScaleFactor(titleScaleFactor)
                    
                    Spacer()
                    Group {
                        if self.inputStyle == .Currency {
                            Text(nForm.roundForCurrency(number: self.value))
                        } else if inputStyle == .TwoDecimalPercent {
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                        } else if inputStyle == .ThreeDecimalPercent {
                            Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value))
                        } else {
                            Text(nForm.formatIntegerNumbers(Int(self.value)))
                        }
                    }
                    .font(Font(self.userPrefs.headlineFont(size: 30)))
                    .minimumScaleFactor(contentScaleFactor)
                }
                .padding(.horizontal)
//                .lineLimit(1)
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.background, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.background))
//                .modifier(NeumorphicStyle(viewBackgroundAccentColor: Color(.white), buttonColor: Color("DropShadowBlue")))
            
        }
    }
}

struct ListInputHalfRow: View {
    @Binding var value: Double
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @EnvironmentObject var userPrefs: UserPreferences
    var inputStyle: InputStyles
    var title: String
    var field: EditableTextFields
    var background: UIColor = .white
    
    var body: some View {
        Button(action: {
            self.inputs.activeField = self.field
            if !self.userPrefs.reduceHaptics { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
        }) {
            VStack {
                Text(self.title)
                    .font(Font(self.userPrefs.headlineFont(size: 24)))
                    .frame(maxWidth: .infinity)
                    .minimumScaleFactor(titleScaleFactor)
                
                Group {
                    if self.inputStyle == .Currency {
                        Text(nForm.roundForCurrency(number: self.value))
                    } else if inputStyle == .TwoDecimalPercent {
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                    } else if inputStyle == .ThreeDecimalPercent {
                        Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value))
                    } else {
                        Text(nForm.formatIntegerNumbers(Int(self.value)))
                    }
                }
                .font(Font(self.userPrefs.headlineFont(size: 30)))
                .frame(maxWidth: .infinity)
                .minimumScaleFactor(contentScaleFactor)
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.background, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.background))
            
        }
    }
}

struct ListDisplayRow: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @EnvironmentObject var userPrefs: UserPreferences
    @Binding var value: Double
    var inputStyle: InputStyles
    var title: String
    
    var body: some View {
        ZStack {
            HStack {
                Text(self.title)
                    .font(Font(self.userPrefs.headlineFont(size: 24)))
                    .minimumScaleFactor(titleScaleFactor)
                
                Spacer()
                Group {
                    if self.inputStyle == .Currency {
                        Text(nForm.roundForCurrency(number: self.value))
                    } else if inputStyle == .TwoDecimalPercent {
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value))
                    } else if inputStyle == .ThreeDecimalPercent {
                        Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value))
                    } else {
                        Text(nForm.formatIntegerNumbers(Int(self.value)))
                    }
                }
                .font(Font(self.userPrefs.headlineFont(size: 30)))
                .minimumScaleFactor(contentScaleFactor)
            }
            .padding()
        }
        .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isFlat: true)))
        .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isInputCard: false))
    }
}

struct VenueButton: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var body: some View {
        Button(action: {
            self.inputs.activeField = .venue
            if !self.userPrefs.reduceHaptics { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
        }) {
            VStack {
                
                HStack {
                    Text("Venue")
                        .font(Font(self.userPrefs.headlineFont(size: 24)))
                        .minimumScaleFactor(titleScaleFactor)
                    
                    Spacer()
                    
                    Text(self.calcModel.selectedVenue.name)
                        .font(Font(self.userPrefs.headlineFont(size: 30)))
                        .minimumScaleFactor(contentScaleFactor)
                }
                .padding(.horizontal)
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark))
            .id("\(self.calcModel.selectedVenue.name)")
        }
    }
}

struct VenueHalfButton: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var body: some View {
        Button(action: {
            self.inputs.activeField = .venue
            if !self.userPrefs.reduceHaptics { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
        }) {
            VStack {
                Text("Venue")
                    .font(Font(self.userPrefs.headlineFont(size: 24)))
                    .frame(maxWidth: .infinity)
                    .minimumScaleFactor(titleScaleFactor)
                
                Text(self.calcModel.selectedVenue.name.capitalized)
                    .font(Font(self.userPrefs.headlineFont(size: 30)))
                    .frame(maxWidth: .infinity)
                    .minimumScaleFactor(contentScaleFactor)
                
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark))
            .id("\(self.calcModel.selectedVenue.name)")
        }
    }
}

struct ListRows_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            MainPageSheet(maxHeight: geo.size.height)
                .environmentObject(UserPreferences.sharedInstance)
        }
    }
}
