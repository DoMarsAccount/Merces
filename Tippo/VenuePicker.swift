//
//  VenuePicker.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct VenuePicker: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var calcModel = CalculationsModel.sharedInstance
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var venues = Venues.sharedInstance
    @ObservedObject var themes = Themes.sharedInstance
    
    var body: some View {
//        GeometryReader { geo in
            VStack {
                HStack {
                    Text("Done")
                        .onTapGesture {
                            self.inputs.activeField = .none
                        }
                        .font(Font(UserPreferences.sharedInstance.headlineFont(size: 32)))
                    Spacer()
                }
                .padding(.top)
                
                Picker(selection: self.$calcModel.selectedVenue, label: Text("Venues")) {
                    ForEach(self.venues.venues, id: \.self) { venue in
                        Text(venue.name.capitalized)
                            .tag(venue)
                            .font(Font(UserPreferences.sharedInstance.headlineFont(size: 48)))
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .id(venues.pickerID)
            }
            .padding()
//            .frame(width: geo.size.width, height: geo.size.height)
            .foregroundColor(self.colorScheme == .dark ? Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.mainColorDark, isFlat: true)) : Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.mainColor, isFlat: true)))
            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, usePadding: false, isInputCard: true))
//        }
    }
}

//struct PPageVenuePicker: View {
//    @ObservedObject var venueEditor = UserPreferences.sharedInstance.venueEditor
//
//        var body: some View {
//            VStack {
//                Picker("Venue", selection: self.$venueEditor.selectedVenue) {
//                    ForEach(1..<VenueType.allCases.count) { index in
//                        Text(VenueType.allCases[index].emoji)
//                            .tag(VenueType.allCases[index])
//                            .accessibility(value: Text("Venue: \(VenueType.allCases[index].name)"))
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//            }
//        }
//}
//
//struct VenueView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @ObservedObject var themes = Themes.sharedInstance
//    @ObservedObject var calcModel = CalculationsModel.sharedInstance
//    var venue: VenueType
//    @ObservedObject var inputs = InputProcessing.sharedInstance
//    var body: some View {
//        ZStack {
//            Color(self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
//                .opacity(self.calcModel.selectedVenue == self.venue ? 0.5 : 0.25)
//
//            VStack {
//                Text(self.venue.emoji)
//                    .font(.system(size: self.calcModel.selectedVenue == self.venue ? 32 : 18))
////                    .padding()
//                Text(self.venue.name)
//                    .font(.system(size: 24, weight: self.calcModel.selectedVenue == self.venue ? .bold : .regular, design: .default))
//                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
//            }
//        }
//        .border(self.calcModel.selectedVenue == self.venue ? Color.green : Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)), width: 4)
//        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//        .onTapGesture {
//            self.calcModel.selectedVenue = self.venue
//            self.inputs.activeField = .none
//        }
//    }
//}

//struct VenueSelectionView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @ObservedObject var themes = Themes.sharedInstance
//    @ObservedObject var calcModel = CalculationsModel.sharedInstance
//    var body: some View {
//        GeometryReader { geo in
//            VStack {
//                HStack {
//                    VenueView(venue: .bar)
//                    VenueView(venue: .quick)
//                    VenueView(venue: .dining)
//                }
//                
//                HStack {
//                    VenueView(venue: .taxi)
//                    VenueView(venue: .salon)
//                    VenueView(venue: .delivery)
//                }
//            }
//            .modifier(AdaptiveCardBackground(backgroundColor: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark))
//        }
//    }
//}

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

struct VenuePicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VenueEditingView()
                .environmentObject(UserPreferences.sharedInstance)
        }
//        VenuePicker()
//        VenueSelectionView()
//        PPageVenuePicker()
    }
}
