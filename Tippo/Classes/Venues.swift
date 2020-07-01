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
    
    @Published var badServiceTipAmount: Double
    @Published var goodServiceTipAmount: Double
    @Published var greatServiceTipAmount: Double
    
    init() {
        badServiceTipAmount = 0.0
        goodServiceTipAmount = 0.0
        greatServiceTipAmount = 0.0
    }
    
    func reset() {
        badServiceTipAmount = 0.0
        goodServiceTipAmount = 0.0
        greatServiceTipAmount = 0.0
    }
}

class Venues: ObservableObject {
    @Published var venues: [Venue] = []
    static let sharedInstance = Venues()
    
    init() {
        let defaultPrefsFile = Bundle.main.path(forResource: "defaultPreferences", ofType: "plist")
        let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile!)
        UserDefaults(suiteName:"group.DoMarsToyBox.Merces")?.register(defaults: defaultPreferences! as! [String : AnyObject])
        
        let venueNames = mUserDefaults?.value(forKey: "venueNames") as! [String]
        let defaultVenue = mUserDefaults?.value(forKey: "defaultVenue") as! String
        for name in venueNames {
            if let tipRates = tipRates(for: name) {
                venues.append(Venue(name: name, tipAmounts: tipRates, isDefaultVenue: name == defaultVenue))
            }
        }
//        print(venueNames)
    }
    
    func createNewVenue(named name: String, tipAmounts: [Double]) -> Bool {
        var existingVenueNames = mUserDefaults?.value(forKey: "venueNames") as! [String]
        
        if !existingVenueNames.contains(name) {
            existingVenueNames.append(name)
            mUserDefaults?.set(existingVenueNames, forKey: "venueNames")
            
            mUserDefaults?.setValue(tipAmounts, forKey: "\(name.lowercased())TipArray")
            
            venues.append(Venue(name: name, tipAmounts: tipAmounts))
            return true
        }
        return false
    }
    
    func updateExistingVenue(named name: String, tipAmounts: [Double]) {
        mUserDefaults?.setValue(tipAmounts, forKey: "\(name.lowercased())TipArray")
        
        // Reset, Update Venues
        self.venues.removeAll()
        let venueNames = mUserDefaults?.value(forKey: "venueNames") as! [String]
        
        for name in venueNames {
            if let tipRates = tipRates(for: name) {
                venues.append(Venue(name: name, tipAmounts: tipRates))
            } else {
                venues.append(Venue(name: name, tipAmounts: [0.0, 0.0, 0.0]))
            }
        }
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
        print(existingVenueNames)
        mUserDefaults?.set(existingVenueNames, forKey: "venueNames")
    }
    
    func updateDefaultVenue(newVenue name: String) {
        mUserDefaults?.set(name, forKey: "defaultVenue")
        
        self.venues.removeAll()
        let venueNames = mUserDefaults?.value(forKey: "venueNames") as! [String]
        
        for vName in venueNames {
            if let tipRates = tipRates(for: vName) {
                venues.append(Venue(name: vName, tipAmounts: tipRates, isDefaultVenue: vName == name))
            }
        }
    }
    
}
