//
//  ListStyleMainPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/22/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ListStyleMainPage: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var isSettingsActive: Bool = false
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    @Binding var isOpen: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack(spacing: 16) {
                    ListInputRow(value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
                    if !self.userPrefs.subtotalIsPostTax {
                        ListInputRow(value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    }
                    
                    ListInputRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                    
//                    VenueButton()
                    
                    ListInputRow(value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                }
        
                ZStack {
                
                    VenueSelectionView()
                        .offset(x: self.inputs.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
                
                    Keypad()
                        .offset(x: (self.inputs.activeField != .none && self.inputs.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
                    
                    ListStyleTotaledAmounts()
                    
                }
                .frame(maxHeight: geo.size.height / 3)
                .minimumScaleFactor(0.75)
                .animation(.spring(response: 0.7, dampingFraction: 0.9, blendDuration: 1.0))
                
            }
            .background(Color("Background"))
        }
    }
}

struct ListStyleTotaledAmounts: View {
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    var body: some View {
        VStack {
            if (self.calcModel.tipAmount != 0) {
                ListDisplayRow(value: self.$calcModel.tipAmount, inputStyle: .Currency, title: "Tip Amount")
                    .id("\(self.calcModel.tipAmount)")
            }
            
            if (self.calcModel.partySize != 1) {
                ListDisplayRow(value: self.$calcModel.totalAmountPerPerson, inputStyle: .Currency, title: "Total Per Person")
                    .id("\(self.calcModel.totalAmountPerPerson)")
            }
            
            ListDisplayRow(value: self.$calcModel.totalAmount, inputStyle: .Currency, title: "Grand Total")
                .id("\(self.calcModel.totalAmount)")
        }
        .offset(x: self.inputs.activeField == .none ? 0 : UIScreen.main.bounds.maxX)
    }
}

struct ListStyleMainPage_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleMainPage(isOpen: .constant(true)).environmentObject(UserPreferences.sharedInstance)
            .padding()
    }
}

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
                    Text(self.calcModel.selectedVenue.name)
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
