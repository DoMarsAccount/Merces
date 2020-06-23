//
//  UserPreferences.swift
//  TipTok
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
        willSet { // Ensures only one rounding behavior can be active at a time
            if self.roundTotalAmount { self.roundTotalAmount.toggle() }
        }
        didSet {
            updatePreferences()
        }
    }
    @Published var roundTotalAmount: Bool {
        willSet { // Ensures only one rounding behavior can be active at a time
            if self.roundTipAmount { self.roundTipAmount.toggle() }
        }
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
    @Published var shouldShowSetupAlert: Bool {
        didSet {
            mUserDefaults!.set(true, forKey: "setupAlertShown")
        }
    }
    @Published var useFlatStyleViews: Bool {
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
        shouldShowSetupAlert = !mUserDefaults!.bool(forKey: "setupAlertShown")
        useFlatStyleViews = mUserDefaults!.bool(forKey: "useFlatStyleViews")
    }
    
    func updatePreferences() {
        mUserDefaults!.set(tipIncludeTax, forKey: "tipIncludeTaxSwitchOnOff")
        mUserDefaults!.set(roundTipAmount, forKey: "roundTipAmountSwitchOnOff")
        mUserDefaults!.set(roundTotalAmount, forKey: "roundTotalAmountSwitchOnOff")
        mUserDefaults!.set(subtotalIsPostTax, forKey: "subtotalIsPostTaxSwitchOnOff")
        mUserDefaults!.set(useDynamicText, forKey: "useDynamicText")
        mUserDefaults!.set(localSalesTax, forKey: "userLocalSalesTax")
        mUserDefaults!.set(useFlatStyleViews, forKey: "useFlatStyleViews")
    }
    
    func checkForDynamicType(preferredFontSize: CGFloat) -> UIFont {
        if mUserDefaults?.bool(forKey: "useDynamicText") == true {
            return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        } else {
            return UIFont(name: "HelveticaNeue-CondensedBlack", size: preferredFontSize)!
        }
    }
}

extension UserDefaults {
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            do {
            try color = NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor
            } catch {
                return nil
            }
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            do {
                try colorData = NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
            } catch {
                print("Color failed in conversion to type Data")
            }
            set(colorData, forKey: key)
        }
    }
}
