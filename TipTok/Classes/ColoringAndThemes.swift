//
//  ColoringAndThemes.swift
//  TipTok
//
//  Created by Donovan McCray on 3/7/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

enum TipTokColor: CaseIterable, Hashable, Identifiable {
    case MercesGreen
    case White
    case Black
    case FadedBlue
    case LightGray
    case Gold
    case RoseGold
    case CamoGreen
    case Tan
    case Purple
    case Blue
    case BurntOrange
    case HotPink
    case NeonGreen
    case BrightRed
    case Brown
    
    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }
    
    var stringRepresentation: String {
        return "\(ColoringAndThemes().uiColorValue(for: self))"
    }
    
    var id: TipTokColor { self }
}

class ColoringAndThemes {
    
    let appleWatchObject = AppleWatchColors()
    
    
    let camoGreen = UIColor(red: 0.549, green: 0.627, blue: 0.490, alpha: 1)
    
    let tan =  UIColor(red: 1.0, green: 0.97254901960784, blue: 0.91372549019608, alpha: 1)
    
    let textColor = UIColor(red: 0.30980392, green: 0.31372549, blue: 0.31764706, alpha: 1)
    
    let textColor2 = UIColor(red:0.682, green:0.706, blue:0.749, alpha:1)
    
    let watchMainColor = UIColor(red: 0.549, green: 0.627, blue: 0.490, alpha: 1)
    
    let watchTextColor = UIColor(red: 1.0, green: 0.97254901960784, blue: 0.91372549019608, alpha: 1)
    
    // #4
    //let appIconGreen1 = UIColor(red:0.51, green:0.85, blue:0.57, alpha:1.0)
    
    // #2
    //let appIconGreen2 = UIColor(red:0.46, green:0.73, blue:0.56, alpha:1.0)
    
    // #1
    // #6BAB8C in Hex
    let appIconGreen3 = UIColor(red:0.42, green:0.67, blue:0.55, alpha:1.0)
    
    // #3
    let appIconGreen4 = UIColor(red:0.04, green:0.85, blue:0.57, alpha:1.0)
    
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
    
    
    func uiColorValue(for TTColor: TipTokColor) -> UIColor {
        switch TTColor {
        case .MercesGreen:
            return UIColor(red:0.42, green:0.67, blue:0.55, alpha:1.0)
        case .White:
            return .white
        case .Black:
            return .black
        case .FadedBlue:
            return appleWatchObject.leatherLoopBrightBlue
        case .LightGray:
            return appleBackgroundColor
        case .Gold:
            return appleWatchObject.gold
        case .RoseGold:
            return appleWatchObject.roseGold
        case .CamoGreen:
            return camoGreen
        case .Tan:
            return tan
        case .Purple:
            return fiveDollarBillPurple
        case .Blue:
            return hundredDollarBillBlue
        case .BurntOrange:
            return hundredDollarBillOrange
        case .HotPink:
            return appleMusicColor
        case .NeonGreen:
            return appleMessagesColor
        case .BrightRed:
            return appleWatchObject.modernBuckleBrightRed
        case .Brown:
            return appleWatchObject.modernBuckleBrown
        }
    }
    
    func getMainColor() -> UIColor {
        if let currentMainColor = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneMainColor") {
            //print("\(UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneMainColor"))")
            return uiColor(for: currentMainColor)
        }
        return appIconGreen3
    }
    
    func getBackgroundColor() -> UIColor {
        if let currentBackgroundColor = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneBackgroundColor") {
            //print("\(UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneBackgroundColor"))")
            return uiColor(for: currentBackgroundColor)
        }
        return appleBackgroundColor
    }
    
    func getViewBackgroundColor() -> UIColor {
        if let currentViewBackgroundColor = mUserDefaults?.string(forKey: "phoneViewBackgroundColor") {
            //print("\(UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.string(forKey: "phoneViewBackgroundColor"))")
            return uiColor(for: currentViewBackgroundColor)
        }
        return UIColor.white
        
    }
    
    func getTextColor() -> UIColor {
        if let currentTextColor = mUserDefaults?.string(forKey: "phoneTextColor") {
            return uiColor(for: currentTextColor)
            
        }
        return textColor
    }
    
    func getMainColorForWatch() -> UIColor {
        
        if let currentMainColor = mUserDefaults?.string(forKey: "watchMainColor") {
            return uiColor(for: currentMainColor)
        }
        return watchMainColor
        
    }
    
    func getSecondaryColorForWatch() -> UIColor {
        if let currentTextColor = mUserDefaults?.string(forKey: "watchTextColor") {
            return uiColor(for: currentTextColor)
        }
        return watchTextColor
    }
    
    func uiColor(for detailedString: String) -> UIColor {
        for TTColor in TipTokColor.allCases {
            if TTColor.stringRepresentation.elementsEqual(detailedString) {
                return uiColorValue(for: TTColor)
            }
        }
        return .white
    }
}
