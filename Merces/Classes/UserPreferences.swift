//
//  UserPreferences.swift
//  Merces
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import UIKit

let mUserDefaults = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces"))

class UserPreferences {
    var tipIncludeTax: Bool
    var roundTipAmount: Bool
    var roundTotalAmount: Bool
    var subtotalIsPostTax: Bool
    var useDynamicText: Bool
    
    var isModeTipCalc: Bool = true
    var localSalesTax: Double = (mUserDefaults?.double(forKey: "userLocalSalesTax"))!
    
    init() {
        tipIncludeTax = mUserDefaults!.bool(forKey: "tipIncludeTaxSwitchOnOff")
        roundTipAmount = mUserDefaults!.bool(forKey: "roundTipAmountSwitchOnOff")
        roundTotalAmount = mUserDefaults!.bool(forKey: "roundTotalAmountSwitchOnOff")
        subtotalIsPostTax = mUserDefaults!.bool(forKey: "subtotalIsPostTaxSwitchOnOff")
        useDynamicText = mUserDefaults!.bool(forKey: "useDynamicText")

        localSalesTax = mUserDefaults!.double(forKey: "userLocalSalesTax")
    }
    
    func checkForDynamicType(preferredFontSize: CGFloat) -> UIFont {
        if mUserDefaults?.bool(forKey: "useDynamicText") == true {
            return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        } else {
            return UIFont(name: "HelveticaNeue-CondensedBold", size: preferredFontSize)!
        }
    }
    
    
}
