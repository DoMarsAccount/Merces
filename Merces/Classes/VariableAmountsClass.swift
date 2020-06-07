//
//  VariableAmountsClass.swift
//  merces
//
//  Created by Donovan McCray on 2/22/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

class VariableAmountsClass
{
    /* Objects */
    let numberFormattingObject = NumberFormattingClass()
    let tipModel = TippingModel()
    let userPrefs = UserPreferences()
    
    /* Variables */
    
    var tipRateArray = mUserDefaults?.array(forKey: "quickTipArray") as! [Double]
    
    var arrayOfButtonsPressedForBillAmountAsString: [String] = []
    var arrayOfButtonsPressedForTaxAmountAsString: [String] = []
    var arrayOfButtonsPressedForTipRateAsString: [String] = []
    var arrayOfButtonsPressedForNumberOfPeoplePayingAsString: [String] = []
    
    var firstResponderTag = 0
    
    /* Functions */
    
    func calculate(_ arrayOfPressedButtonValues: [String], activeField: EditableTextFields){
        
        var inputAmount = 0.00
        
        if !arrayOfPressedButtonValues.isEmpty {
            
            inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
            
        } else {
            
            inputAmount = 0.00
            
        }
        
        checkResponderStatus(inputAmount, activeField: activeField)
    }
    
    func display(_ arrayOfPressedButtonValues: [String], activeField: EditableTextFields) {
        
        var inputAmount = 1.0
        
        if !arrayOfPressedButtonValues.isEmpty {
            inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
            
        } else {
            inputAmount = 1.0
        }
        
        if inputAmount == 0.0 {
            inputAmount = 1.0
        }
        
        checkResponderStatus(inputAmount, activeField: activeField)
    }
    
    func checkResponderStatus(_ inputAmount: Double, activeField: EditableTextFields) {
        
        switch activeField {
        case .subtotal:
            tipModel.subtotal = inputAmount
            useTaxAmount(false)
            
        case .salesTax:
            tipModel.taxAmount = inputAmount
            useTaxAmount(true)
            
        case .numPeople:
            if inputAmount >= 2147483647 {
                arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
                tipModel.partySize = 0
                
            } else {
                if inputAmount != 1 {
                    tipModel.partySize = Int(inputAmount * 100)
                    
                } else {
                    tipModel.partySize = Int(inputAmount)
                    
                }
            }
            
        case .tipRate:
            tipModel.tipRate = inputAmount * 0.01
            
        case .venue:
            userPrefs.localSalesTax = inputAmount * 0.001
            
        default:
            break
            
        }
    }
    
    func useTaxAmount(_ doEditTaxAmount: Bool) {
        var locallyCalculatedTaxAmount = tipModel.subtotal * userPrefs.localSalesTax
        
        if mUserDefaults?.double(forKey: "userLocalSalesTax") != 0.0 {
            
            locallyCalculatedTaxAmount = tipModel.subtotal * userPrefs.localSalesTax
        }
        
        if doEditTaxAmount != true {
            tipModel.taxAmount = locallyCalculatedTaxAmount
        }
    }
    
    
    func updateValues() -> (formattedBillAmount: String, formattedTaxAmount: String, formattedTipRate: String, numberOfPeoplePaying: String, tipAmount: String, totalAmount: String, totalAmountPerPerson: String) {
        
        return tipModel.computeTippingValues()
        
    }
    
    func resetValues() {
        
        tipModel.partySize = 1
        
        tipModel.totalAmount = 0.00
        
        tipModel.totalAmountPerPerson = 0.00
        
        tipModel.tipAmount = 0.0
        
        tipModel.subtotal = 0.00
        
        tipModel.tipRate = 0.0
        
        tipModel.taxAmount = 0.00
        
        tipModel.selectedVenue = .quick
        
        tipRateArray = tipRates(for: self.tipModel.selectedVenue)
        
        arrayOfButtonsPressedForBillAmountAsString = []
        arrayOfButtonsPressedForTaxAmountAsString = []
        arrayOfButtonsPressedForTipRateAsString = []
        arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
        
       
    }
    
    func updateSubtotalForPostTaxDesired() {
        
        // Here because adjusted amount should only be displayed once
        // user is done editing
        if UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "subtotalIsPostTaxSwitchOnOff") == true {
            
            tipModel.subtotal = tipModel.subtotal / (1 + userPrefs.localSalesTax)
            
            tipModel.taxAmount = tipModel.subtotal * userPrefs.localSalesTax
            
        }
        
        // MUST be followed by a call to updateValues()
        
    }
    
}
