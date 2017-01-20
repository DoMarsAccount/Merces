//
//  NumberFormattingClass.swift
//  merces
//
//  Created by Donovan McCray on 2/22/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import Foundation

class NumberFormattingClass {
    
    // Rounds the entered Double value into a variant that includes the $
    
    func roundForCurrency (number: Double) -> String {
        
        let formatter = NumberFormatter()
        
        formatter.locale = Locale.current
        
        if UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "roundToNearestDollarSwitchOnOff") == true {
            
            formatter.roundingMode = NumberFormatter.RoundingMode.up
            
            
        } else {
            
            formatter.roundingMode = NumberFormatter.RoundingMode.halfEven
            
        }
        
        formatter.numberStyle = NumberFormatter.Style.currency
       
        return formatter.string(from: NSNumber(floatLiteral: number))!
        
    }
    
    
    // Rounds the entered Double value into a variant that includes the %
    
    
    func roundForPercentWithDecimalPlace(_ number: Double) -> String {
        
        let formatter = NumberFormatter()
        
        formatter.locale = Locale.current
        
        
        
        formatter.numberStyle = NumberFormatter.Style.percent
        
        formatter.minimumFractionDigits = 2
        
        
        
        return formatter.string(from: NSNumber(floatLiteral: number))!
        
        
    }
    
    func roundForPercentWithThreeDecimalPlaces(number: Double) -> String {
        
        let formatter = NumberFormatter()
        
        formatter.locale = Locale.current
        
        formatter.numberStyle = NumberFormatter.Style.percent
        
        formatter.minimumFractionDigits = 3
        
        
        return formatter.string(from: NSNumber(floatLiteral: number))!
        
    }
    
    
    func formatIntegerNumbers (_ number: Int) -> String {
        
        let formatter = NumberFormatter()
        
        formatter.locale = Locale.current
        
        formatter.numberStyle = NumberFormatter.Style.decimal
        
        
        return formatter.string(from: NSNumber(integerLiteral: number))!
        
    }
    
}
