//
//  Venues.swift
//  Tippo
//
//  Created by Donovan McCray on 6/29/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import Foundation

struct Venue: Hashable {
    var name: String
    var tipAmounts: [Double]
    var isDefaultVenue: Bool = false
}

class VenueCreator: ObservableObject {
    static let sharedInstance = VenueCreator()
    
    @Published var service: ServiceQuality {
        didSet {
            switch self.service {
            case .Bad:
                self.activeField = .newBadTip
            case .Good:
                self.activeField = .newGoodTip
            case .Great:
                self.activeField = .newGreatTip
            }
        }
    }
    @Published var activeField: EditableTextFields
    @Published var tipAmount: Double {
        didSet {
            switch service {
            case .Bad:
                badServiceTipAmount = tipAmount
            case .Good:
                goodServiceTipAmount = tipAmount
            case .Great:
                greatServiceTipAmount = tipAmount
            }
        }
    }
    @Published var badServiceTipAmount: Double
    @Published var goodServiceTipAmount: Double
    @Published var greatServiceTipAmount: Double
    
    init() {
        service = .Good
        activeField = .newGoodTip
        tipAmount = 0.0
        badServiceTipAmount = 0.0
        goodServiceTipAmount = 0.0
        greatServiceTipAmount = 0.0
    }
    
    func currentTipRate(service: ServiceQuality) -> Double {
        switch service {
        case .Bad:
            return badServiceTipAmount
        case .Good:
            return goodServiceTipAmount
        case .Great:
            return greatServiceTipAmount
        }
    }
    
    func reset() {
        service = .Good
        activeField = .newGoodTip
        tipAmount = 0.0
        badServiceTipAmount = 0.0
        goodServiceTipAmount = 0.0
        greatServiceTipAmount = 0.0
    }
}

class Venues: ObservableObject {
    @Published var venues: [Venue] = [Venue]()
    @Published var selectedVenue: Venue
    @Published var pickerID: UUID
    static let sharedInstance = Venues()
    
    private init() {
        let defaultPrefsFile = Bundle.main.path(forResource: "defaultPreferences", ofType: "plist")
        let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile!)
        UserDefaults(suiteName:"group.DoMarsToyBox.Merces")?.register(defaults: defaultPreferences! as! [String : AnyObject])
        
        selectedVenue = Venue(name: "None", tipAmounts: [0.0, 0.0, 0.0])
        pickerID = UUID()
        
        let venueNames = mUserDefaults?.value(forKey: "venueNames") as! [String]
        let defaultVenue = mUserDefaults?.value(forKey: "defaultVenue") as! String
        for name in venueNames {
            if let tipRates = tipRates(for: name) {
                let venue = Venue(name: name, tipAmounts: tipRates, isDefaultVenue: name == defaultVenue)
                venues.append(venue)
                if venue.isDefaultVenue { selectedVenue = venue }
            }
        }
    }
    
    func createNewVenue(named name: String, tipAmounts: [Double]) -> Bool {
        var existingVenueNames = mUserDefaults?.value(forKey: "venueNames") as! [String]
        if !existingVenueNames.contains(name) {
            existingVenueNames.append(name)
            mUserDefaults?.set(existingVenueNames, forKey: "venueNames")
            mUserDefaults?.setValue(tipAmounts, forKey: "\(name.lowercased())TipArray")
            refreshVenuesArray()
            return true
        }
        return false
    }
    
    func updateExistingVenue(named name: String, tipAmounts: [Double]) {
        mUserDefaults?.setValue(tipAmounts, forKey: "\(name.lowercased())TipArray")
        refreshVenuesArray()
    }
    
    func venue(named name: String) -> Venue? {
        if let tipAmounts = mUserDefaults?.value(forKey: "\(name.lowercased())TipArray") {
            return Venue(name: name, tipAmounts: tipAmounts as! [Double])
        }
        return nil
    }
    
    func tipRates(for name: String) -> [Double]? {
        if let venue = self.venue(named: name) {
            return venue.tipAmounts
        }
        return nil
    }
    
    func deleteVenue(at offsets: IndexSet) {
        var existingVenueNames = mUserDefaults?.value(forKey: "venueNames") as! [String]
        existingVenueNames.remove(atOffsets: offsets)
//        print(existingVenueNames)
        mUserDefaults?.set(existingVenueNames, forKey: "venueNames")
        refreshVenuesArray()
    }
    
    func updateDefaultVenue(newVenue name: String) {
        mUserDefaults?.set(name, forKey: "defaultVenue")
        refreshVenuesArray()
    }
    
    private func refreshVenuesArray() {
        let prevSelectedVenue = selectedVenue.name
        self.venues.removeAll()
        let venueNames = mUserDefaults?.value(forKey: "venueNames") as! [String]
        let defaultVenue = mUserDefaults?.value(forKey: "defaultVenue") as! String
        for vName in venueNames {
            if let tipRates = tipRates(for: vName) {
                let venue = Venue(name: vName, tipAmounts: tipRates, isDefaultVenue: vName == defaultVenue)
                venues.append(venue)
                if venue.name == prevSelectedVenue { selectedVenue = venue }
            }
        }
        pickerID = UUID()
    }
    
    // MARK: Tip Class Replacement Methods
    func currentTipRates(for venue: Venue) -> [Double]? {
        return tipRates(for: venue.name)
    }
    
    func currentTipRate(for venue: Venue, service: ServiceQuality) -> Double? {
        if let tips = tipRates(for: venue.name) {
            switch service {
            case .Bad:
                return tips[0]
            case .Good:
                return tips[1]
            case .Great:
                return tips[2]
            }
        }
        return nil
    }
    
}
