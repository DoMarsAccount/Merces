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
    let calcModel = CalculationsModel.sharedInstance
    let venues = Venues.sharedInstance
    let layoutPrefs = LayoutPreferences.sharedInstance
    
    @Published var tipIncludeTax: Bool {
        didSet {
            mUserDefaults!.set(tipIncludeTax, forKey: "tipIncludeTaxSwitchOnOff")
            self.calcModel.computeTippingValues()
        }
    }
    @Published var roundTipAmount: Bool {
        willSet { // Ensures only one rounding behavior can be active at a time
            if self.roundTotalAmount { self.roundTotalAmount.toggle() }
        }
        didSet {
            mUserDefaults!.set(roundTipAmount, forKey: "roundTipAmountSwitchOnOff")
            self.calcModel.computeTippingValues()
        }
    }
    @Published var roundTotalAmount: Bool {
        willSet { // Ensures only one rounding behavior can be active at a time
            if self.roundTipAmount { self.roundTipAmount.toggle() }
        }
        didSet {
            mUserDefaults!.set(roundTotalAmount, forKey: "roundTotalAmountSwitchOnOff")
            self.calcModel.computeTippingValues()
        }
    }
    @Published var subtotalIsPostTax: Bool {
        didSet {
            mUserDefaults!.set(subtotalIsPostTax, forKey: "subtotalIsPostTaxSwitchOnOff")
            self.calcModel.computeTippingValues()
        }
    }
    @Published var useDynamicText: Bool {
        didSet {
            mUserDefaults!.set(useDynamicText, forKey: "useDynamicText")
        }
    }
    @Published var localSalesTax: Double {
        didSet {
            mUserDefaults!.set(localSalesTax, forKey: "userLocalSalesTax")
            self.calcModel.computeTippingValues()
        }
    }
    @Published var shouldShowSetupAlert: Bool {
        didSet {
            mUserDefaults!.set(true, forKey: "setupAlertShown")
        }
    }
    @Published var useFlatStyleViews: Bool {
        didSet {
            mUserDefaults!.set(useFlatStyleViews, forKey: "useFlatStyleViews")
        }
    }
    @Published var useClassicStyle: Bool {
        didSet {
            mUserDefaults!.set(useClassicStyle, forKey: "useClassicStyle")
        }
    }
    @Published var reduceHaptics: Bool {
        didSet {
            mUserDefaults!.set(reduceHaptics, forKey: "reduceHaptics")
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
        useClassicStyle = mUserDefaults!.bool(forKey: "useClassicStyle")
        reduceHaptics = mUserDefaults!.bool(forKey: "reduceHaptics")
    }
    
    func headlineFont(size: CGFloat) -> UIFont {
        if mUserDefaults?.bool(forKey: "useDynamicText") == true {
            return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        } else {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }
    
    func subHeadlineFont(size: CGFloat) -> UIFont {
        if mUserDefaults?.bool(forKey: "useDynamicText") == true {
            return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        } else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
    
    func bodyFont(size: CGFloat) -> UIFont {
        if mUserDefaults?.bool(forKey: "useDynamicText") == true {
            return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        } else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
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
