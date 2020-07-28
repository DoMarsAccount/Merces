//
//  VenueEditor.swift
//  TipTok
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import SwiftUI

enum ServiceQuality: CaseIterable, Hashable, Identifiable {
    case Bad
    case Good
    case Great
    
    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }
    
    var id: ServiceQuality { self }
    
    var image: Image {
        switch self {
        case .Bad:
            return Image(systemName: "hand.thumbsdown.fill")
        case .Good:
            return Image(systemName: "hand.thumbsup.fill")
        case .Great:
            return Image(systemName: "heart.fill")
        }
    }
}

enum VenueType: CaseIterable, Hashable, Identifiable {
    case none
    case quick
    case bar
    case dining
    case salon
    case taxi
    case delivery

    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }

    var id: VenueType { self }

    var emoji: String {
        switch self {
        case .none:
            return "\u{1F6AB}"
        case .quick:
            return "\u{23E9}"
        case .bar:
            return "\u{1F37A}"
        case .dining:
            return "\u{1F37D}"
        case .salon:
            return "\u{1F488}"
        case .taxi:
            return "\u{1F695}"
        case .delivery:
            return "\u{1F355}"
        }
    }
}

class Tipping {
    static let sharedInstance = Tipping()

    private init() {
        let defaultPrefsFile = Bundle.main.path(forResource: "defaultPreferences", ofType: "plist")

        let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile!)

        UserDefaults(suiteName:"group.DoMarsToyBox.Merces")?.register(defaults: defaultPreferences! as! [String : AnyObject])
    }

    /// Returns the array of tip rates for the given Venue
    func tipRates(for venue: VenueType) -> [Double] {
        switch venue {
        case .quick:
            return mUserDefaults?.array(forKey: "quickTipArray") as! [Double]
        case .bar:
            return mUserDefaults?.array(forKey: "barTipArray") as! [Double]
        case .dining:
            return mUserDefaults?.array(forKey: "diningTipArray") as! [Double]
        case .salon:
            return mUserDefaults?.array(forKey: "salonTipArray") as! [Double]
        case .taxi:
            return mUserDefaults?.array(forKey: "taxiTipArray") as! [Double]
        case .delivery:
            return mUserDefaults?.array(forKey: "deliveryTipArray") as! [Double]
        case .none:
            return [0.0, 0.0, 0.0]
        }
    }

    func currentTipRate(for venue: Venue, service: ServiceQuality) -> Double {
        return Venues.sharedInstance.currentTipRate(for: venue, service: service)!
//        switch service {
//        case .Bad:
//            return tipRates(for: venue)[0]
//        case .Good:
//            return tipRates(for: venue)[1]
//        case .Great:
//            return tipRates(for: venue)[2]
//        }
    }
}

func localizedName(for venue: VenueType) -> String {
    switch venue {
    case .quick:
        return "Quick"
    case .bar:
        return NSLocalizedString("Bar", comment: "Bar")
    case .dining:
        return NSLocalizedString("Dining", comment:"Dining")
    case .salon:
        return NSLocalizedString("Salon", comment:"Salon")
    case .taxi:
        return NSLocalizedString("Taxi", comment:"Taxi")
    case .delivery:
        return NSLocalizedString("Delivery", comment:"Delivery")
    case .none:
        return "None"
    }
}



/// Wrapper around VenueEditor that update the user's Tip Ratings stored in UserDefaults
func userDefinedTipRatings (_ arrayOfPressedButtonValues: [String], serviceQuality: ServiceQuality) {

    let venueEditor = VenueEditor.sharedInstance

    var inputAmount = 0.00
    if !arrayOfPressedButtonValues.isEmpty {
        inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
    }
    
    switch serviceQuality {
    case .Bad:
        venueEditor.service = .Bad
    case .Good:
        venueEditor.service = .Good
    case .Great:
        venueEditor.service = .Great
    }
    venueEditor.tipAmount = inputAmount * 0.01
}

class VenueEditor: ObservableObject {
    static let sharedInstance = VenueEditor()
    var venues = Venues.sharedInstance
    
    @Published var service: ServiceQuality {
        didSet {
            switch self.service {
            case .Bad:
                self.activeField = .badTip
            case .Good:
                self.activeField = .goodTip
            case .Great:
                self.activeField = .greatTip
            }
        }
    }
    @Published var activeField: EditableTextFields
    @Published var tipAmount: Double {
        didSet {
            if (!shouldReset) {
                self.changeTipRating(for: self.venues.selectedVenue, quality: self.service, newRating: self.tipAmount)
            }
        }
    }
    /* iOS Personalization Page Only*/
    @Published var badServiceTipAmount: Double {
        willSet { self.service = .Bad }
        didSet {
            self.changeTipRating(for: self.venues.selectedVenue, quality: .Bad, newRating: self.badServiceTipAmount)
        }
    }
    @Published var goodServiceTipAmount: Double {
        willSet { self.service = .Good }
        didSet {
            self.changeTipRating(for: self.venues.selectedVenue, quality: .Good, newRating: self.goodServiceTipAmount)
        }
    }
    @Published var greatServiceTipAmount: Double {
        willSet { self.service = .Great }
        didSet {
            self.changeTipRating(for: self.venues.selectedVenue, quality: .Great, newRating: self.greatServiceTipAmount)
        }
    }
    private var shouldReset: Bool = false

    private init() {
        service = .Good
        activeField = .goodTip
        
        if let tipRates = venues.currentTipRates(for: venues.selectedVenue) {
            tipAmount = tipRates[1]
            badServiceTipAmount = tipRates[0]
            goodServiceTipAmount = tipRates[1]
            greatServiceTipAmount = tipRates[2]
        } else {
            tipAmount = 0.0
            badServiceTipAmount = 0.0
            goodServiceTipAmount = 0.0
            greatServiceTipAmount = 00.0
        }
    }

    /// Update the tip rating for the given venue and quality in UserDefaults
    func changeTipRating(for venue: Venue, quality: ServiceQuality, newRating: Double) {

        var index: Int = 0
        switch quality {
        case .Bad:
            index = 0
        case .Good:
            index = 1
        case .Great:
            index = 2
        }

        if let venueArray = venues.currentTipRates(for: venue) {
            var newArray = venueArray
            newArray[index] = newRating //* 0.01
            venues.updateExistingVenue(named: venue.name, tipAmounts: newArray)
        } else {
            return
        }
    }

    func resetTipAmount() {
        self.shouldReset = true
        self.tipAmount = 0.0
        self.shouldReset = false
    }
}
