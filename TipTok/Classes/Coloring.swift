//
//  ColoringAndThemes.swift
//  TipTok
//
//  Created by Donovan McCray on 3/7/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import SwiftUI

enum TipTokColor: CaseIterable, Hashable, Identifiable {
    case MercesGreen
    case CrayolaRed
    case SeaSerpent
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
        return "\(Coloring().uiColorValue(for: self))"
    }
    
    var id: TipTokColor { self }
    
    var color: UIColor {
        return Coloring().uiColorValue(for: self)
    }
}


class Coloring {
    
    let appleWatchObject = AppleWatchColors()
    
    // #4
    //let appIconGreen1 = UIColor(red:0.51, green:0.85, blue:0.57, alpha:1.0)
    
    // #2
    //let appIconGreen2 = UIColor(red:0.46, green:0.73, blue:0.56, alpha:1.0)
    
    // #1
    // #6BAB8C in Hex
    let appIconGreen3 = UIColor(red:0.42, green:0.67, blue:0.55, alpha:1.0)
    
    // #3
    let appIconGreen4 = UIColor(red:0.04, green:0.85, blue:0.57, alpha:1.0)
    
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
        case .LightGray:    // Apple View Background
            return UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        case .Gold:
            return appleWatchObject.gold
        case .RoseGold:
            return appleWatchObject.roseGold
        case .CamoGreen:
            return UIColor(red: 0.549, green: 0.627, blue: 0.490, alpha: 1)
        case .Tan:
            return UIColor(red: 1.0, green: 0.97254901960784, blue: 0.91372549019608, alpha: 1)
        case .Purple:       // Five Dollar Bill Purple
            return UIColor(red:0.506, green:0.310, blue:0.384, alpha:1)
        case .Blue:         // Hundred Dollar Bill Blue
            return UIColor(red:0.220, green:0.275, blue:0.467, alpha:1)
        case .BurntOrange:
            return UIColor(red:0.722, green:0.420, blue:0.192, alpha:1)
        case .HotPink:      // Apple Music
            return UIColor(red:1.00, green:0.18, blue:0.33, alpha:1.0)
        case .NeonGreen:    // Apple Messages
            return UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0)
        case .BrightRed:
            return appleWatchObject.modernBuckleBrightRed
        case .Brown:
            return appleWatchObject.modernBuckleBrown
        case .CrayolaRed:
            return UIColor(red: 0.933, green: 0.1137254902, blue: 0.3215686275, alpha: 1.0)
        case .SeaSerpent:
            return UIColor(red: 0.3019607843, green: 0.9098039216, blue: 0.9568627451, alpha: 1.0)
        }
    }
    /// Searches through TipTokColors for a color representaiton matching the provided string representation, returning the UIColor value of said TipTokColor
    func uiColor(for detailedString: String) -> UIColor {
        for TTColor in TipTokColor.allCases {
            if TTColor.stringRepresentation.elementsEqual(detailedString) {
                return uiColorValue(for: TTColor)
            }
        }
        return .white
    }
    
    /// Returns TipTokColor matching the provided string representation
    func TTColorRepresentation(for detailedString: String) -> TipTokColor {
        for TTColor in TipTokColor.allCases {
            if TTColor.stringRepresentation.elementsEqual(detailedString) {
                return TTColor
            }
        }
        print("Couldn't successfuly find color")
        return .MercesGreen
    }
    
    /// Returns TipTokColor matching the provided UIColor
    func TTColorRepresentation(for uicolor: UIColor) -> TipTokColor {
        for TTColor in TipTokColor.allCases {
            if self.uiColorValue(for: TTColor) == uicolor {
                return TTColor
            }
        }
        return .MercesGreen
    }
    
    /// Returns true if the provided color values are the same, false otherwise
    func colorsMatch(color1: UIColor, color2: UIColor) -> Bool {
        return color1 == color2
    }
}
