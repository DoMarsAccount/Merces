//
//  UserPreferences.swift
//  Merces
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import UIKit

let mUserDefaults = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces"))

class UserPreferences: ObservableObject {
    static let sharedInstance = UserPreferences()
    let venueEditor = VenueEditor()
    
    @Published var tipIncludeTax: Bool {
        didSet {
            updatePreferences()
        }
    }
    @Published var roundTipAmount: Bool {
           didSet {
               updatePreferences()
           }
       }
    @Published var roundTotalAmount: Bool {
           didSet {
               updatePreferences()
           }
       }
    @Published var subtotalIsPostTax: Bool {
           didSet {
               updatePreferences()
           }
       }
    @Published var useDynamicText: Bool {
           didSet {
               updatePreferences()
           }
       }
    
    @Published var localSalesTax: Double {
        didSet {
            updatePreferences()
        }
    }
    
    var isModeTipCalc: Bool = true
    
    init() {
        tipIncludeTax = mUserDefaults!.bool(forKey: "tipIncludeTaxSwitchOnOff")
        roundTipAmount = mUserDefaults!.bool(forKey: "roundTipAmountSwitchOnOff")
        roundTotalAmount = mUserDefaults!.bool(forKey: "roundTotalAmountSwitchOnOff")
        subtotalIsPostTax = mUserDefaults!.bool(forKey: "subtotalIsPostTaxSwitchOnOff")
        useDynamicText = mUserDefaults!.bool(forKey: "useDynamicText")
        localSalesTax = mUserDefaults!.double(forKey: "userLocalSalesTax")
    }
    
    func updatePreferences() {
        mUserDefaults!.set(tipIncludeTax, forKey: "tipIncludeTaxSwitchOnOff")
        mUserDefaults!.set(roundTipAmount, forKey: "roundTipAmountSwitchOnOff")
        mUserDefaults!.set(roundTotalAmount, forKey: "roundTotalAmountSwitchOnOff")
        mUserDefaults!.set(subtotalIsPostTax, forKey: "subtotalIsPostTaxSwitchOnOff")
        mUserDefaults!.set(useDynamicText, forKey: "useDynamicText")
        mUserDefaults!.set(localSalesTax, forKey: "userLocalSalesTax")
    }
    
    func checkForDynamicType(preferredFontSize: CGFloat) -> UIFont {
        if mUserDefaults?.bool(forKey: "useDynamicText") == true {
            return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        } else {
            return UIFont(name: "HelveticaNeue-CondensedBold", size: preferredFontSize)!
        }
    }
}
