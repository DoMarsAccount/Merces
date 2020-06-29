//
//  Venues.swift
//  Merces_SwiftUI
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import Foundation

enum ServiceQuality: CaseIterable, Hashable, Identifiable {
    case Poor
    case Average
    case Great
    
    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }
    
    var id: ServiceQuality { self }
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

func tipRate(for venue: VenueType, service: ServiceQuality) -> Double {
    switch service {
    case .Poor:
        return tipRates(for: venue)[0]
    case .Average:
        return tipRates(for: venue)[1]
    case .Great:
        return tipRates(for: venue)[2]
    }
}

/// Update the user's Tip Ratings stored in NSUserDefaults
func userDefinedTipRatings (_ arrayOfPressedButtonValues: [String], venueToEdit: VenueType, tipRateToEdit: Int) {
    
    var inputAmount = 0.00
    if !arrayOfPressedButtonValues.isEmpty {
        inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
    }

    /*
     0 = Poor
     1 = Average
     2 = Great
     */
    
    if tipRateToEdit >= 0 && tipRateToEdit <= 2 {
        
        var venueArray: [Double] = tipRates(for: venueToEdit)
        venueArray[tipRateToEdit] = inputAmount * 0.01
        
        switch venueToEdit {
        case .quick:
            mUserDefaults?.setValue(venueArray, forKey: "quickTipArray")
        case .bar:
            mUserDefaults?.setValue(venueArray, forKey: "barTipArray")
        case .dining:
            mUserDefaults?.setValue(venueArray, forKey: "diningTipArray")
        case .salon:
            mUserDefaults?.setValue(venueArray, forKey: "salonTipArray")
        case .taxi:
            mUserDefaults?.setValue(venueArray, forKey: "taxiTipArray")
        case .delivery:
            mUserDefaults?.setValue(venueArray, forKey: "deliveryTipArray")
        case .none: // should never use this case
            return
        }
    }
}

class VenueEditor: ObservableObject {
    @Published var selectedVenue: VenueType
    @Published var service: ServiceQuality
    
    @Published var poorTipAmount: Double
    @Published var averageTipAmount: Double
    @Published var greatTipAmount: Double
    
    init() {
        selectedVenue = .quick
        service = .Average
        
        poorTipAmount = 0.0
        averageTipAmount = 0.0
        greatTipAmount = 0.0
    }
}
