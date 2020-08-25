//
//  VariableAmountsClass.swift
//  TipTok
//
//  Created by Donovan McCray on 2/22/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

enum EditableTextFields: CaseIterable, Hashable, Identifiable {
    case subtotal
    case salesTax
    case partySize
    case tipRate
    case venue
    case localTax
    case badTip
    case goodTip
    case greatTip
    case none
    
    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }
    
    var id: EditableTextFields { self }
}

let varAmts = InputProcessing()

class InputProcessing
{
    /* Objects */
    let calcModel = CalculationsModel.sharedInstance
    let venueEditor = UserPreferences.sharedInstance.venueEditor
    
    /* Variables */
    var tipRateArray: [Double]
    
    var arrayOfButtonsPressedForBillAmountAsString: [String] {
        didSet {
            processInput(self.arrayOfButtonsPressedForBillAmountAsString, activeField: .subtotal)
        }
    }
    var arrayOfButtonsPressedForTaxAmountAsString: [String] {
        didSet {
            processInput(self.arrayOfButtonsPressedForTaxAmountAsString, activeField: .salesTax)
        }
    }
    var arrayOfButtonsPressedForTipRateAsString: [String] {
        didSet {
            processInput(self.arrayOfButtonsPressedForTipRateAsString, activeField: .tipRate)
        }
    }
    var arrayOfButtonsPressedForNumberOfPeoplePayingAsString: [String] {
        didSet {
            processInput(self.arrayOfButtonsPressedForNumberOfPeoplePayingAsString, activeField: .partySize)
        }
    }
    var arrayOfButtonsPressedForLocalSalesTax: [String] {
        didSet {
            processInput(self.arrayOfButtonsPressedForLocalSalesTax, activeField: .localTax)
        }
    }
    
    var arrayOfButtonsPressedForPoorTip: [String] {
        didSet {
            userDefinedTipRatings(self.arrayOfButtonsPressedForPoorTip, venueToEdit: self.venueEditor.selectedVenue, tipRateToEdit: 0)
        }
    }
    var arrayOfButtonsPressedForAverageTip: [String] {
        didSet {
            userDefinedTipRatings(self.arrayOfButtonsPressedForAverageTip, venueToEdit: self.venueEditor.selectedVenue, tipRateToEdit: 1)
        }
    }
    var arrayOfButtonsPressedForGreatTip: [String] {
        didSet {
            userDefinedTipRatings(self.arrayOfButtonsPressedForGreatTip, venueToEdit: self.venueEditor.selectedVenue, tipRateToEdit: 2)
        }
    }
    
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
        arrayOfButtonsPressedForLocalSalesTax = []
        
        arrayOfButtonsPressedForPoorTip = []
        arrayOfButtonsPressedForAverageTip = []
        arrayOfButtonsPressedForGreatTip = []
    }
    
    var firstResponderTag = 0
    
    /* Functions */
    
    func processInput(_ arrayOfPressedButtonValues: [String], activeField: EditableTextFields) {
        var inputAmount = 0.0
        
        if !arrayOfPressedButtonValues.isEmpty {
            if (arrayOfPressedButtonValues.count <= 15) {
                inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
            }
           
       } else {
           switch activeField {
           case .partySize:
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
            
        case .partySize:
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
            calcModel.tipRate = inputAmount * 0.01
            
        case .localTax:
            UserPreferences.sharedInstance.localSalesTax = inputAmount * 0.001
            
        default:
            break
            
        }
    }
    
    func useTaxAmount(_ doEditTaxAmount: Bool) {
        if !UserPreferences.sharedInstance.subtotalIsPostTax {
            var locallyCalculatedTaxAmount = calcModel.subtotal * UserPreferences.sharedInstance.localSalesTax
            
            if mUserDefaults?.double(forKey: "userLocalSalesTax") != 0.0 {
                locallyCalculatedTaxAmount = calcModel.subtotal * UserPreferences.sharedInstance.localSalesTax
            }
            
            if doEditTaxAmount != true {
                calcModel.taxAmount = locallyCalculatedTaxAmount
            }
        } else {
            calcModel.taxAmount = 0.0
        }
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
        
        tipRateArray = Tipping.sharedInstance.tipRates(for: self.calcModel.selectedVenue)
        
        arrayOfButtonsPressedForBillAmountAsString = []
        arrayOfButtonsPressedForTaxAmountAsString = []
        arrayOfButtonsPressedForTipRateAsString = []
        arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
        
        arrayOfButtonsPressedForPoorTip = []
        arrayOfButtonsPressedForAverageTip = []
        arrayOfButtonsPressedForGreatTip = []
    }
    
}
