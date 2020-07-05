//
//  LayoutPreferences.swift
//  Tippo
//
//  Created by Donovan McCray on 7/4/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import Foundation

class LayoutPreferences: ObservableObject {
    static let sharedInstance = LayoutPreferences()
    
    @Published var displayVenueCards: Bool {
        didSet {
            mUserDefaults!.set(displayVenueCards, forKey: "displayVenueCards")
        }
    }
    
    init() {
        displayVenueCards = mUserDefaults!.bool(forKey: "displayVenueCards")
    }
}
