//
//  AddVenuePage.swift
//  Tippo
//
//  Created by Donovan McCray on 6/30/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct AddVenuePage: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @ObservedObject var venueEditor = VenueEditor.sharedInstance
    @ObservedObject var newVenue = VenueCreator.sharedInstance
    @ObservedObject var venues = Venues.sharedInstance
    @State private var newVenueName: String = ""
    @Binding var isUserCreatingVenue: Bool
    
    @State private var renameVenueAlertIsShown: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer(minLength: 40)
                HStack {
                    Text("Venue:")
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter a name for the venue...", text: self.$newVenueName, onCommit: {
                        
                    }).onTapGesture {
                        self.inputs.activeField = .none
                    }
                        .padding(.vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.inputs.activeField = EditableTextFields.newBadTip
                    }) {
                        VStack {
                            HStack {
                                Text("Bad")
                                    .font(Font(self.userPrefs.headlineFont(size: 18)))
                                    .scaleEffect(self.inputs.activeField == EditableTextFields.badTip ? highlightedScale : 1.0)
                                ServiceQuality.Bad.image
                            }
                            
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(self.newVenue.badServiceTipAmount))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)), width: 2)
                                .cornerRadius(2)
                                .font(Font(self.userPrefs.headlineFont(size: 18)))
                            
                        }
                    }
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)))
                    .accessibility(label: Text("Bad Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(self.newVenue.badServiceTipAmount))"))
                    
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.inputs.activeField = EditableTextFields.newGoodTip
                    }) {
                        VStack {
                            HStack {
                                Text("Good")
                                    .font(Font(self.userPrefs.headlineFont(size: 18)))
                                    .scaleEffect(self.inputs.activeField == EditableTextFields.goodTip ? highlightedScale : 1.0)
                                ServiceQuality.Good.image
                            }
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(self.newVenue.goodServiceTipAmount))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)), width: 2)
                            .cornerRadius(2)
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                        }
                    }
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)))
                    .accessibility(label: Text("Good Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(self.newVenue.goodServiceTipAmount))"))
                    
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.inputs.activeField = EditableTextFields.newGreatTip
                    }) {
                        VStack {
                            HStack {
                                Text("Great")
                                    .font(Font(self.userPrefs.headlineFont(size: 18)))
                                    .scaleEffect(self.inputs.activeField == EditableTextFields.greatTip ? highlightedScale : 1.0)
                                ServiceQuality.Great.image
                            }
                            Text(nForm.roundForPercentWithTwoDecimalPlaces(self.newVenue.greatServiceTipAmount))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)), width: 2)
                            .cornerRadius(2)
                            .font(Font(self.userPrefs.headlineFont(size: 18)))
                        }
                    }
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? Themes.sharedInstance.viewColor : Themes.sharedInstance.viewColorDark, isFlat: true)))
                    .accessibility(label: Text("Great Service Tip: \(nForm.roundForPercentWithTwoDecimalPlaces(self.newVenue.greatServiceTipAmount))"))
                }
                
                Button(action: {
                    self.isUserCreatingVenue = !self.addVenue()
                }) {
                    Text("Add Venue")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                }
                .padding(.vertical)
                .alert(isPresented: self.$renameVenueAlertIsShown, content: {
                    Alert(title: Text("A Venue named '\(self.newVenueName)' already exists"), message: Text("Do you want to overwrite the existing venue?"), primaryButton: .default(Text("No"), action: {
                        // Allow user to choose a new name
                        self.renameVenueAlertIsShown = false
                    }), secondaryButton: .destructive(Text("Yes"), action: {
                        // Replace the tip rates of the existing venue
                        self.venues.updateExistingVenue(named: self.newVenueName, tipAmounts: [self.newVenue.badServiceTipAmount, self.newVenue.goodServiceTipAmount, self.newVenue.greatServiceTipAmount])
                        self.renameVenueAlertIsShown = false
                        self.isUserCreatingVenue = false
                    }))
                })
//                Spacer()
                
                PPageBottomView()
                
                Keypad()
                    .offset(x: (self.inputs.activeField != .none) ? 0 : UIScreen.main.bounds.maxX)
                    .frame(maxHeight: geo.size.height / 3)
            }
            .padding()
        }
    }
    
    func addVenue() -> Bool {
        self.inputs.activeField = .none
        let result = self.venues.createNewVenue(named: self.newVenueName, tipAmounts: [self.newVenue.badServiceTipAmount, self.newVenue.goodServiceTipAmount, self.newVenue.greatServiceTipAmount])
        if result {
            return true
        } else {
            self.renameVenueAlertIsShown = true
            return false
        }
    }
}

struct AddVenuePage_Previews: PreviewProvider {
    static var previews: some View {
        AddVenuePage(isUserCreatingVenue: .constant(true))
    }
}
