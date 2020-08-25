//
//  VenueEditingView.swift
//  Tippo
//
//  Created by Donovan McCray on 8/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct VenueEditingView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes = Themes.sharedInstance
    @ObservedObject var calcModel = CalculationsModel.sharedInstance
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var venues = Venues.sharedInstance
    @State private var addVenueSheetPresented: Bool = false
    
    var body: some View {
        VStack {
            VenueSelectionList(selectedVenue: self.$venues.selectedVenue)
            
            VStack {
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
                            
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[0]))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)), width: 2)
                                .cornerRadius(2)
                                .font(Font(self.userPrefs.headlineFont(size: 18)))
                            
                        }
                    }
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)))
                    .accessibility(label: Text("Bad Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[0]))"))
                    
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
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[1]))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)), width: 2)
                            .cornerRadius(2)
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                        }
                    }
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)))
                    .accessibility(label: Text("Good Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[1]))"))
                    
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
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[2]))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)), width: 2)
                            .cornerRadius(2)
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                        }
                    }
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)))
                    .accessibility(label: Text("Great Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[2]))"))
                }
                ZStack {
                    PPageBottomView()
                
                    Keypad()
                        .offset(x: (self.inputs.activeField != .none) ? 0 : UIScreen.main.bounds.maxX)
                }
                .minimumScaleFactor(0.75)
                .animation(.spring(response: 0.7, dampingFraction: 0.9, blendDuration: 1.0))
            }
            .padding()
        }
        .navigationBarTitle(Text("Venues"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.addNewVenue()
        }) {
            Image(systemName: "plus")
                .resizable()
                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 16))
        }).accessibility(label: Text("Add a new venue"))
        .sheet(isPresented: self.$addVenueSheetPresented) {
            AddVenuePage(isUserCreatingVenue: self.$addVenueSheetPresented)
        }
    }
    
    private func addNewVenue() {
        self.addVenueSheetPresented = true
    }
}

struct VenueEditingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VenueEditingView()
                .environmentObject(UserPreferences.sharedInstance)
        }
    }
}
