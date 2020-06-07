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
    
    /* Variables */
    
    var totalAmount = 0.00, totalAmountPerPerson = 0.00, tipAmount = 0.0, billAmount = 0.00, tipRate = 0.0, taxAmount = 0.00, displayedTotalAmountPerPerson = 0.0,moreOrLessPerPerson = 0.00
    
    var localSalesTax: Double = (mUserDefaults?.double(forKey: "userLocalSalesTax"))!
    
    var numberOfPeoplePaying = 1
    
    var selectedVenue: VenueType = .quick
    
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
            billAmount = inputAmount
            useTaxAmount(false)
            
        case .salesTax:
            taxAmount = inputAmount
            useTaxAmount(true)
            
        case .numPeople:
            if inputAmount >= 2147483647 {
                arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
                numberOfPeoplePaying = 0
                
            } else {
                if inputAmount != 1 {
                    numberOfPeoplePaying = Int(inputAmount * 100)
                    
                } else {
                    numberOfPeoplePaying = Int(inputAmount)
                    
                }
            }
            
        case .tipRate:
            tipRate = inputAmount * 0.01
            
        case .venue:
            localSalesTax = inputAmount * 0.001
            
        default:
            break
            
        }
    }
    
    func useTaxAmount(_ doEditTaxAmount: Bool) {
        var locallyCalculatedTaxAmount = billAmount * localSalesTax
        
        if mUserDefaults?.double(forKey: "userLocalSalesTax") != 0.0 {
            
            locallyCalculatedTaxAmount = billAmount * localSalesTax
        }
        
        if doEditTaxAmount != true {
            taxAmount = locallyCalculatedTaxAmount
        }
    }
    
    
    func updateValues() -> (formattedBillAmount: String, formattedTaxAmount: String, formattedTipRate: String, numberOfPeoplePaying: String, tipAmount: String, totalAmount: String, totalAmountPerPerson: String) {
        
        tipAmount = (mUserDefaults!.bool(forKey: "tipIncludeTaxSwitchOnOff") ? (billAmount + taxAmount) * tipRate : billAmount * tipRate)
        
        
        totalAmount = billAmount + tipAmount + taxAmount
        
        totalAmountPerPerson = totalAmount / Double(numberOfPeoplePaying)
        
        if mUserDefaults?.bool(forKey: "roundTipAmountSwitchOnOff") == true {
            
            tipAmount = ceil(tipAmount)
            
            totalAmount = billAmount + tipAmount + taxAmount
            
            totalAmountPerPerson = totalAmount / Double(numberOfPeoplePaying)
            
        }
        
        if mUserDefaults?.bool(forKey: "roundTotalAmountSwitchOnOff") == true {
            
            totalAmount = ceil(billAmount + tipAmount + taxAmount)
            
            totalAmountPerPerson = ceil(totalAmount / Double(numberOfPeoplePaying))
            
        }
        
        // Checks for repeating decimal in the tip per person 
        // if value is > 0, it will be rounded upward, meaning not all need to pay "extra"
        // else value is rounded down, meaning some need to pay a little more
        
        // if Num being displayed isn't the same as the a
//        if (numberFormattingObject.roundForCurrency(number: totalAmountPerPerson)) != "\(totalAmountPerPerson.roundTo(places: 2))" {
//            
//            
//            
//        }
        
        if ("$\(totalAmountPerPerson.roundTo(places: 2))" == numberFormattingObject.roundForCurrency(number: totalAmountPerPerson)) && ("$\(totalAmountPerPerson.roundTo(places: 2) * Double(numberOfPeoplePaying))" == numberFormattingObject.roundForCurrency(number: totalAmount)){
            
            moreOrLessPerPerson = 0
            
        } else if numberOfPeoplePaying > 1 {
            
            moreOrLessPerPerson = ((totalAmountPerPerson * Double(numberOfPeoplePaying)) - (totalAmountPerPerson.roundTo(places: 2) * Double(numberOfPeoplePaying))) * 100
            
        } else {
            
            moreOrLessPerPerson = 0
            
        }
        
        return (numberFormattingObject.roundForCurrency(number: billAmount), numberFormattingObject.roundForCurrency(number: taxAmount), numberFormattingObject.roundForPercentWithDecimalPlace(tipRate),"\(numberOfPeoplePaying)", numberFormattingObject.roundForCurrency(number: tipAmount), numberFormattingObject.roundForCurrency(number: totalAmount), numberFormattingObject.roundForCurrency(number: totalAmountPerPerson))
        
    }
    
    func resetValues() {
        
        numberOfPeoplePaying = 1
        
        totalAmount = 0.00
        
        totalAmountPerPerson = 0.00
        
        tipAmount = 0.0
        
        billAmount = 0.00
        
        tipRate = 0.0
        
        taxAmount = 0.00
        
        selectedVenue = .quick
        
        tipRateArray = tipRates(for: self.selectedVenue)
        
        arrayOfButtonsPressedForBillAmountAsString = []
        arrayOfButtonsPressedForTaxAmountAsString = []
        arrayOfButtonsPressedForTipRateAsString = []
        arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
        
       
    }
    
    func updateSubtotalForPostTaxDesired() {
        
        // Here because adjusted amount should only be displayed once
        // user is done editing
        if UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "subtotalIsPostTaxSwitchOnOff") == true {
            
            billAmount = billAmount / (1 + localSalesTax)
            
            taxAmount = billAmount * localSalesTax
            
        }
        
        // MUST be followed by a call to updateValues()
        
    }
    
}
