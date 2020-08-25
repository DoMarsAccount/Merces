//
//  VenuesView.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/10/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct VenueEditingView: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var isKeypadPresented: Bool = false
    
    var body: some View {
        VStack(spacing: viewHeight) {
            VenuesView()
                .padding([.top])
        }
        .navigationBarTitle("Done")
    }
}

struct UpdateTipsView: View {
    @EnvironmentObject var wCalcModel: CalculationsModel
    @State private var isActive: Bool = false {
        didSet {
            venueEditor.resetTipAmount()
        }
    }
    @ObservedObject var venueEditor = VenueEditor.sharedInstance
    @ObservedObject var venues = Venues.sharedInstance
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Updating: \(self.venues.selectedVenue.name.capitalized)")
                .font(.headline)
            
            Divider()
            
            HStack {
                Text("Tip %").font(.headline)
                Spacer()
                Text(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venues.selectedVenue, service: self.venueEditor.service)))
            }
                .padding([.leading, .trailing])
                .frame(height: viewHeight)
                .frame(maxWidth: .infinity)
                .background(Color("TippoIndigo"))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                .onTapGesture {
                    self.isActive.toggle()
                }
                .sheet(isPresented: self.$isActive) {
                    Keypad(value: self.$venueEditor.tipAmount, isPresented: self.$isActive, activeField: self.$venueEditor.activeField)
                }
                .accessibility(label: Text("Tip Rate \(nForm.roundForPercentWithTwoDecimalPlaces(Tipping.sharedInstance.currentTipRate(for: self.venues.selectedVenue, service: self.venueEditor.service)))"))
            
            Picker(selection: self.$venueEditor.service, label: Text("Service Level")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.8)
                    .accessibility(label: Text("Service Level: \(self.venueEditor.service.name)"))
            ){
                ForEach(0..<ServiceQuality.allCases.count) { index in
                    HStack {
                        Text(ServiceQuality.allCases[index].name)
                        ServiceQuality.allCases[index].image
                    }
                    .tag(ServiceQuality.allCases[index])
                    .accessibility(value: Text("Service Level: \(ServiceQuality.allCases[index].name)"))
                }
            }.frame(height: viewHeight)
        }
    }
}

struct VenuesView: View {
    @EnvironmentObject var wCalcModel: CalculationsModel
    @State private var isActive: Bool = false {
        didSet {
            venueEditor.resetTipAmount()
        }
    }
    @ObservedObject var venueEditor = VenueEditor.sharedInstance
    @ObservedObject var venues = Venues.sharedInstance
    
    @State private var isUpdateTipsViewActive: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                
                Picker(selection: self.$venues.selectedVenue, label: Text("Venue").font(.headline)
                    .accessibility(label: Text("Venue: \(self.venues.selectedVenue.name)"))
                ) {
                    ForEach(self.venues.venues, id: \.self) { venue in
                        Text(venue.name.capitalized).tag(venue.name)
                            .accessibility(label: Text("Venue: \(venue.name)"))
                    }
                }
                .frame(height: viewHeight)
                
                Group {
                    HStack {
                        Text("Bad:")
                        Spacer()
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[0]))
                    }
                    HStack {
                        Text("Good:")
                        Spacer()
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[1]))
                    }
                    HStack {
                        Text("Great:")
                        Spacer()
                        Text(nForm.roundForPercentWithTwoDecimalPlaces(self.venues.selectedVenue.tipAmounts[2]))
                    }
                }

                Divider()
                
                NavigationLink(destination: UpdateTipsView(), isActive: $isUpdateTipsViewActive) {
                    Text("Update Tip Rates")
                        .minimumScaleFactor(0.5)
                }
                .modifier(scalingEffect())
                
                Button(action: {
                    self.venues.updateDefaultVenue(newVenue: self.venues.selectedVenue.name)
                }) {
                    Text("Make Default Venue")
                        .minimumScaleFactor(0.5)
                }
                .modifier(scalingEffect())
                
                Button(action: {
                    self.venues.deleteVenue(named: self.venues.selectedVenue.name)
                }) {
                    Text("Delete Venue")
                        .minimumScaleFactor(0.5)
                }
                .modifier(scalingEffect())
            }
        }
    }
}

struct AddVenueView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    @ObservedObject var newVenue = VenueCreator.sharedInstance
    @ObservedObject var venues = Venues.sharedInstance
    @State private var newVenueName: String = ""
    @Binding var isUserCreatingVenue: Bool
    
    @State private var renameVenueAlertIsShown: Bool = false
    @State private var isActive: Bool = false {
        didSet {
//            newVenue.reset()
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                TextField("New venue name", text: self.$newVenueName)
                
                HStack {
                    Text("Tip %").font(.headline)
                    Spacer()
                    
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(self.newVenue.currentTipRate(service: self.newVenue.service)))
                }
                    .padding([.leading, .trailing])
                    .frame(height: viewHeight)
                    .frame(maxWidth: .infinity)
                    .background(Color("CrayolaRed"))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                    .onTapGesture {
                        self.isActive.toggle()
                    }
                    .sheet(isPresented: self.$isActive) {
                        Group {
                            if self.newVenue.service == .Bad {
                                Keypad(value: self.$newVenue.badServiceTipAmount, isPresented: self.$isActive, activeField: self.$newVenue.activeField)
                            } else if self.newVenue.service == .Good {
                                Keypad(value: self.$newVenue.goodServiceTipAmount, isPresented: self.$isActive, activeField: self.$newVenue.activeField)
                            } else {
                                Keypad(value: self.$newVenue.greatServiceTipAmount, isPresented: self.$isActive, activeField: self.$newVenue.activeField)
                            }
                        }
                    }
                    .accessibility(label: Text("Tip Rate \(nForm.roundForPercentWithTwoDecimalPlaces(self.newVenue.currentTipRate(service: self.newVenue.service)))"))
                
                Picker(selection: self.$newVenue.service, label: Text("Service Level")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.8)
                        .accessibility(label: Text("Service Level: \(self.newVenue.service.name)"))
                ){
                    ForEach(0..<ServiceQuality.allCases.count) { index in
                        HStack {
                            Text(ServiceQuality.allCases[index].name)
                            ServiceQuality.allCases[index].image
                        }
                        .tag(ServiceQuality.allCases[index])
                        .accessibility(value: Text("Service Level: \(ServiceQuality.allCases[index].name)"))
                    }
                }.frame(height: viewHeight)
                
                Button(action: {
                    self.isUserCreatingVenue = !self.addVenue()
                }) {
                    Text("Add Venue")
    //                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                }
                .frame(height: viewHeight)
            }
        }
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
    }
    
    func addVenue() -> Bool {
        let result = self.venues.createNewVenue(named: self.newVenueName, tipAmounts: [self.newVenue.badServiceTipAmount, self.newVenue.goodServiceTipAmount, self.newVenue.greatServiceTipAmount])
        if result {
            return true
        } else {
            self.renameVenueAlertIsShown = true
            return false
        }
    }
}

struct VenuesView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesView().environmentObject(CalculationsModel.sharedInstance)
    }
}
