//
//  ColoringAndThemes.swift
//  merces
//
//  Created by Donovan McCray on 3/7/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

class ColoringAndThemes {
    
    let appleWatchObject = AppleWatchColors()
    
    
    let camoGreen = UIColor(red: 0.549, green: 0.627, blue: 0.490, alpha: 1)
    
    let tan =  UIColor(red: 1.0, green: 0.97254901960784, blue: 0.91372549019608, alpha: 1)
    
    let textColor = UIColor(red: 0.30980392, green: 0.31372549, blue: 0.31764706, alpha: 1)
    
    let textColor2 = UIColor(red:0.682, green:0.706, blue:0.749, alpha:1)
    
    let watchMainColor = UIColor(red: 0.549, green: 0.627, blue: 0.490, alpha: 1)
    
    let watchTextColor = UIColor(red: 1.0, green: 0.97254901960784, blue: 0.91372549019608, alpha: 1)
    
    
    // Light Gray (Default)
    let appleBackgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
    
    // Hot Pink
    let appleMusicColor = UIColor(red:1.00, green:0.18, blue:0.33, alpha:1.0)
    
    // Neon Green
    let appleMessagesColor = UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0)
    
    // Purple
    let fiveDollarBillPurple = UIColor(red:0.506, green:0.310, blue:0.384, alpha:1)
    
    // Orange
    let hundredDollarBillOrange = UIColor(red:0.722, green:0.420, blue:0.192, alpha:1)
    
    // Blue
    let hundredDollarBillBlue = UIColor(red:0.220, green:0.275, blue:0.467, alpha:1)
    
    
    /* ----- Array With All Color Values ------ */
    
    var arrayOfAllColors: [UIColor]!
    
    var arrayOfAllColorNames: [String]!
    
    
    /* Functions */
    
    init() {
        
        arrayOfAllColors = [appleWatchObject.leatherLoopBrightBlue, appleBackgroundColor, appleWatchObject.gold, appleWatchObject.roseGold, camoGreen, tan, fiveDollarBillPurple, hundredDollarBillBlue, hundredDollarBillOrange, appleMusicColor, appleMessagesColor, appleWatchObject.sportBandWhite, appleWatchObject.modernBuckleBlack, appleWatchObject.modernBuckleBrightRed, appleWatchObject.modernBuckleBrown ]
        
        arrayOfAllColorNames = ["Faded Blue (Default)", "Light Gray (Default)", "Gold", "Rose Gold", "Camo Green", "Tan", "Purple", "Blue", "Orange", "Hot Pink", "Neon Green", "White", "Black", "Bright Red", "Brown"]
        
        
    }
    
    func getMainColor() -> UIColor {
        
        if let currentMainColor = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneMainColor") {
            
            //print("\(UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneMainColor"))")
            
            return switchOfColors(currentColor: currentMainColor)
            
        }
        
        return appleWatchObject.leatherLoopBrightBlue
    }
    
    func getBackgroundColor() -> UIColor {
        
        if let currentBackgroundColor = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneBackgroundColor") {
            
            //print("\(UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneBackgroundColor"))")
            
            
            return switchOfColors(currentColor: currentBackgroundColor)
            
        }
        
        return appleBackgroundColor
        
    }
    
    func getViewBackgroundColor() -> UIColor {
        
        return UIColor.white
        
    }
    
    func getTextColor() -> UIColor {
        
        if let currentTextColor = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneTextColor") {
            
            
            return switchOfColors(currentColor: currentTextColor)
            
        }
        
        return textColor
    }
    
    func getMainColorForWatch() -> UIColor {
        
        if let currentMainColor = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "watchMainColor") {
            
            return switchOfColors(currentColor: currentMainColor)
            
        }
        
        return watchMainColor
        
    }
    
    func getSecondaryColorForWatch() -> UIColor {
        
        if let currentTextColor = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "watchTextColor") {
            
            
            return switchOfColors(currentColor: currentTextColor)
        }
        
        return watchTextColor
    }
    
    func switchOfColors(currentColor: String) -> UIColor {
        
        switch currentColor {
            
        case "UIExtendedSRGBColorSpace 0.549 0.627 0.49 1":
            
            return camoGreen
            
        case "UIExtendedSRGBColorSpace 1 0.972549 0.913725 1":
            
            return tan
            
        case "UIExtendedSRGBColorSpace 0.309804 0.313725 0.317647 1":
            
            return textColor
            
        case "UIExtendedSRGBColorSpace 0.506 0.31 0.384 1":
            
            return fiveDollarBillPurple
            
        case "UIExtendedSRGBColorSpace 0.22 0.275 0.467 1":
            
            return hundredDollarBillBlue
            
        case "UIExtendedSRGBColorSpace 0.722 0.42 0.192 1":
            
            return hundredDollarBillOrange
            
        case "UIExtendedSRGBColorSpace 0.651 0.651 0.651 1":
            
            return appleWatchObject.silverAluminum
            
        case "UIExtendedSRGBColorSpace 0.325 0.325 0.325 1":
            
            return appleWatchObject.spaceGrayAluminum
            
        case "UIExtendedSRGBColorSpace 0.96 0.89 0.8 1":
            
            return appleWatchObject.gold
            
        case "UIExtendedSRGBColorSpace 0.97 0.85 0.83 1":
            
            return appleWatchObject.roseGold
            
            // Modern Buckle colors
            
        case "UIExtendedSRGBColorSpace 0.816 0.294 0.231 1":
            
            return appleWatchObject.modernBuckleBrightRed
            
        case "UIExtendedSRGBColorSpace 0.271 0.29 0.369 1":
            
            return appleWatchObject.modernBuckleMidnightBlue
            
        case "UIExtendedSRGBColorSpace 0.573 0.443 0.341 1":
            
            return appleWatchObject.modernBuckleBrown
            
        case "UIExtendedSRGBColorSpace 0.922 0.843 0.824 1":
            
            return appleWatchObject.modernBuckleSoftPink
            
        case "UIExtendedSRGBColorSpace 0.2 0.2 0.2 1":
            
            return appleWatchObject.modernBuckleBlack
            
            // Sport Band Colors
            
        case "UIExtendedSRGBColorSpace 0.694 0.788 0.42 1":
            
            return appleWatchObject.sportBandGreen
            
        case "UIExtendedSRGBColorSpace 0.318 0.659 0.89 1":
            
            return appleWatchObject.sportBandBlue
            
        case "UIExtendedSRGBColorSpace 0.976 0.447 0.424 1":
            
            return appleWatchObject.sportBandPink
            
        case "UIExtendedSRGBColorSpace 0.969 0.969 0.969 1":
            
            return appleWatchObject.sportBandWhite
            
            // Leather Buckle Colors
            
        case "UIExtendedSRGBColorSpace 0.365 0.4 0.537 1":
            
            return appleWatchObject.leatherLoopBrightBlue
            
        case "UIExtendedSRGBColorSpace 0.6 0.518 0.478 1":
            
            return appleWatchObject.leatherLoopLightBrown
            
        case "UIExtendedSRGBColorSpace 0.671 0.627 0.604 1":
            
            return appleWatchObject.leatherLoopStone
            
        case "UIExtendedSRGBColorSpace 1 0.18 0.33 1":
            
            return appleMusicColor
            
        case "UIExtendedSRGBColorSpace 0.3 0.85 0.39 1":
            
            return appleMessagesColor
            
        case "UIExtendedSRGBColorSpace 0.94 0.94 0.96 1":
            
            return appleBackgroundColor
            
        default:
            
            return textColor
            
        }
        
        
    }

    
    
}
