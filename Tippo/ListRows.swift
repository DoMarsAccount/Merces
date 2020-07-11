//
//  ListRows.swift
//  Tippo
//
//  Created by Donovan McCray on 7/6/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

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
//                        .font(.title)
                        .font(Font(self.userPrefs.headlineFont(size: 24)))
                    
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
                }
                .padding(.horizontal)
                .minimumScaleFactor(0.8)
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
                HStack {
                    Text(self.title)
//                        .font(.headline)
                        .font(Font(self.userPrefs.headlineFont(size: 24)))
                    Spacer()
                }
                .minimumScaleFactor(0.8)
                
                HStack {
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
                    .minimumScaleFactor(0.8)
                    .font(Font(self.userPrefs.headlineFont(size: 30)))
                }
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.background, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.background))
//                .modifier(NeumorphicStyle(viewBackgroundAccentColor: Color(.white), buttonColor: Color("DropShadowBlue")))
            
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
//                    .font(.title)

                    .font(Font(self.userPrefs.headlineFont(size: 24)))
                
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
            }
            .padding()
            .minimumScaleFactor(0.8)
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
                    
                    Spacer()
                    
                    Text(self.calcModel.selectedVenue.name)
                    .font(Font(self.userPrefs.headlineFont(size: 30)))
                }
                .padding(.horizontal)
                .minimumScaleFactor(0.8)
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
                HStack {
                    Text("Venue")
                    .font(Font(self.userPrefs.headlineFont(size: 24)))
                    Spacer()
                }
                .minimumScaleFactor(0.8)
                
                HStack {
                    Spacer()
                    Text(self.calcModel.selectedVenue.name.capitalized)
                    .font(Font(self.userPrefs.headlineFont(size: 30)))
                        .minimumScaleFactor(0.8)
                }
                
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark))
            .id("\(self.calcModel.selectedVenue.name)")
        }
    }
}

struct ListRows_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleMainPage(isOpen: .constant(true)).environmentObject(UserPreferences.sharedInstance)
        .padding()
    }
}
