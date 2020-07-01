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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if self.horizontalSizeClass == .compact {
                        if self.verticalSizeClass == .regular {
                            CompactWidthRegularHeightListStyle()
                        } else {
                            CompactWidthCompactHeightListStyle()
                        }
                    } else {
                        if self.verticalSizeClass == .regular {
                            RegularWidthRegulartHeightListStyle()
                        } else {
                            CompactWidthCompactHeightListStyle()
                        }
                    }
                }
                .padding()
                .navigationBarTitle(Text("Tippo"), displayMode: .automatic)
                .navigationBarItems(trailing: NavigationLink(destination: Settings(), isActive: self.$isSettingsActive) {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .accessibility(label: Text("Settings"))
                        .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
                })
            }
        }
//        .background(NavigationConfigurator { nc in
//            nc.navigationBar.backgroundColor = (self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
//            nc.navigationBar.barTintColor = (self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
//            nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
//            nc.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
//            nc.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)
//        })
    }
}

struct ListStyleMainPage_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleMainPage().environmentObject(UserPreferences.sharedInstance)
    }
}

struct ListInputRow: View {
    @Binding var value: Double
    @ObservedObject var inputs = InputProcessing.sharedInstance
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
                        .font(.title)
                    
                    Spacer()
                    
                    if self.inputStyle == .Currency {
                        Text(nForm.roundForCurrency(number: self.value)).font(.largeTitle)
                    } else if inputStyle == .TwoDecimalPercent {
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value)).font(.largeTitle)
                    } else if inputStyle == .ThreeDecimalPercent {
                        Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value)).font(.largeTitle)
                    } else {
                        Text(nForm.formatIntegerNumbers(Int(self.value))).font(.largeTitle)
                    }
                }
                .padding()
                .minimumScaleFactor(0.8)
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.background, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.background))
            
        }
    }
}

struct ListDisplayRow: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @Binding var value: Double
    var inputStyle: InputStyles
    var title: String
    
    var body: some View {
        ZStack {
            HStack {
                Text(self.title)
                    .font(.title)
                
                Spacer()
                
                if self.inputStyle == .Currency {
                    Text(nForm.roundForCurrency(number: self.value)).font(.largeTitle)
                } else if inputStyle == .TwoDecimalPercent {
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(self.value)).font(.largeTitle)
                } else if inputStyle == .ThreeDecimalPercent {
                    Text(nForm.roundForPercentWithThreeDecimalPlaces(number: self.value)).font(.largeTitle)
                } else {
                    Text(nForm.formatIntegerNumbers(Int(self.value))).font(.largeTitle)
                }
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
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var body: some View {
        Button(action: {
            self.inputs.activeField = .venue
        }) {
            ZStack {
                
                HStack {
                    Text("Venue")
                        .font(.title)
                    
                    Spacer()
                    
                    Text(self.calcModel.selectedVenue.name)
                        .font(.largeTitle)
                }
                .padding()
                .minimumScaleFactor(0.8)
            }
            .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark))
            
        }
    }
}
