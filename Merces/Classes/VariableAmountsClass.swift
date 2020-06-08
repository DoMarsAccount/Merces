//
//  VariableAmountsClass.swift
//  merces
//
//  Created by Donovan McCray on 2/22/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

let userPrefs = UserPreferences()
let varAmts = VariableAmountsClass()

class VariableAmountsClass
{
    /* Objects */
    let calcModel = CalculationsModel()
    
    /* Variables */
    var tipRateArray: [Double]
    
    var arrayOfButtonsPressedForBillAmountAsString: [String] {
        didSet {
            processInput(self.arrayOfButtonsPressedForBillAmountAsString, activeField: .subtotal)
        }
    }
    
    var arrayOfButtonsPressedForTaxAmountAsString: [String]
    var arrayOfButtonsPressedForTipRateAsString: [String]
    var arrayOfButtonsPressedForNumberOfPeoplePayingAsString: [String]
    
    init() {
        if let tipArray = mUserDefaults?.array(forKey: "quickTipArray") {
            tipRateArray = tipArray as! [Double]
        } else {
            tipRateArray = [0.0, 0.0, 0.0]
        }
        
        arrayOfButtonsPressedForBillAmountAsString = []
        arrayOfButtonsPressedForTaxAmountAsString = []
        arrayOfButtonsPressedForTipRateAsString = []
        arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
    }
    
    var firstResponderTag = 0
    
    /* Functions */
    
    func processInput(_ arrayOfPressedButtonValues: [String], activeField: EditableTextFields) {
        var inputAmount = 0.0
        
        if !arrayOfPressedButtonValues.isEmpty {
           inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
           
       } else {
           switch activeField {
           case .numPeople:
               inputAmount = 1.0
           default:
               inputAmount = 0.0
           }
       }
        checkInputFormat(inputAmount, activeField: activeField)
    }
    
    func checkInputFormat(_ inputAmount: Double, activeField: EditableTextFields) {
        
        switch activeField {
        case .subtotal:
            calcModel.subtotal = inputAmount
            useTaxAmount(false)
            
        case .salesTax:
            calcModel.taxAmount = inputAmount
            useTaxAmount(true)
            
        case .numPeople:
            if inputAmount >= 2147483647 {
                arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
                calcModel.partySize = 0
                
            } else {
                
                if inputAmount != 1 {

                    if inputAmount == 0.0 { 
                        calcModel.partySize = 1
                    } else {
                        calcModel.partySize = Int(inputAmount * 100)
                    }
                    
                } else {
                    calcModel.partySize = Int(inputAmount)
                    
                }
            }
            
        case .tipRate:
            calcModel.tipRate = inputAmount
            
        case .venue:
            userPrefs.localSalesTax = inputAmount * 0.001
            
        default:
            break
            
        }
    }
    
    func useTaxAmount(_ doEditTaxAmount: Bool) {
        var locallyCalculatedTaxAmount = calcModel.subtotal * userPrefs.localSalesTax
        
        if mUserDefaults?.double(forKey: "userLocalSalesTax") != 0.0 {
            
            locallyCalculatedTaxAmount = calcModel.subtotal * userPrefs.localSalesTax
        }
        
        if doEditTaxAmount != true {
            calcModel.taxAmount = locallyCalculatedTaxAmount
        }
    }
    
    
    func updateValues() -> (formattedBillAmount: String, formattedTaxAmount: String, formattedTipRate: String, numberOfPeoplePaying: String, tipAmount: String, totalAmount: String, totalAmountPerPerson: String) {
        
        return calcModel.computeTippingValues()
        
    }
    
    func resetValues() {
        
        calcModel.partySize = 1
        
        calcModel.totalAmount = 0.00
        
        calcModel.totalAmountPerPerson = 0.00
        
        calcModel.tipAmount = 0.0
        
        calcModel.subtotal = 0.00
        
        calcModel.tipRate = 0.0
        
        calcModel.taxAmount = 0.00
        
        calcModel.selectedVenue = .quick
        
        tipRateArray = tipRates(for: self.calcModel.selectedVenue)
        
        arrayOfButtonsPressedForBillAmountAsString = []
        arrayOfButtonsPressedForTaxAmountAsString = []
        arrayOfButtonsPressedForTipRateAsString = []
        arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
    }
    
    func updateSubtotalForPostTaxDesired() {
        
        // Here because adjusted amount should only be displayed once
        // user is done editing
        if UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "subtotalIsPostTaxSwitchOnOff") == true {
            
            calcModel.subtotal = calcModel.subtotal / (1 + userPrefs.localSalesTax)
            
            calcModel.taxAmount = calcModel.subtotal * userPrefs.localSalesTax
            
        }
        
        // MUST be followed by a call to updateValues()
        
    }
    
}
