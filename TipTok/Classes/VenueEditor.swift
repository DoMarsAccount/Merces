//
//  Venues.swift
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

func currentTipRate(for venue: VenueType, service: ServiceQuality) -> Double {
    switch service {
    case .Bad:
        return tipRates(for: venue)[0]
    case .Good:
        return tipRates(for: venue)[1]
    case .Great:
        return tipRates(for: venue)[2]
    }
}

/// Wrapper around VenueEditor that update the user's Tip Ratings stored in UserDefaults
func userDefinedTipRatings (_ arrayOfPressedButtonValues: [String], venueToEdit: VenueType, tipRateToEdit: Int) {
    
    let venueEditor = UserPreferences.sharedInstance.venueEditor
    
    var inputAmount = 0.00
    if !arrayOfPressedButtonValues.isEmpty {
        inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
    }
    venueEditor.selectedVenue = venueToEdit
    switch tipRateToEdit {
    case 0:
        venueEditor.service = .Bad
    case 1:
        venueEditor.service = .Good
    case 2:
        venueEditor.service = .Great
    default:
        break
    }
    venueEditor.tipAmount = inputAmount * 0.01
}

class VenueEditor: ObservableObject {
    @Published var selectedVenue: VenueType
    @Published var service: ServiceQuality {
        didSet {
            switch self.service {
            case .Bad:
                self.activeField = .poorTip
            case .Good:
                self.activeField = .averageTip
            case .Great:
                self.activeField = .greatTip
            }
        }
    }
    @Published var activeField: EditableTextFields
    @Published var tipAmount: Double {
        didSet {
            if (!shouldReset) {
                self.changeTipRating(for: self.selectedVenue, quality: self.service, newRating: self.tipAmount)
            }
            
        }
    }
    private var shouldReset: Bool = false
    
    init() {
        selectedVenue = .quick
        service = .Good
        activeField = .averageTip
        
        tipAmount = currentTipRate(for: .quick, service: .Good)
    }
    
    /// Update the tip rating for the given venue and quality in UserDefaults
    func changeTipRating(for venue: VenueType, quality: ServiceQuality, newRating: Double) {
        
        var index: Int = 0
        switch quality {
        case .Bad:
            index = 0
        case .Good:
            index = 1
        case .Great:
            index = 2
        }
        
        var venueArray = tipRates(for: venue)
        venueArray[index] = newRating //* 0.01
        
        switch venue {
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
        default:
            break
        }
    }
    
    func resetTipAmount() {
        self.shouldReset = true
        self.tipAmount = 0.0
        self.shouldReset = false
    }
    
}
