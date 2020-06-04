//
//  VariableAmountsClass.swift
//  merces
//
//  Created by Donovan McCray on 2/22/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class VariableAmountsClass
{
    
    /* Objects */
    
    let numberFormattingObject = NumberFormattingClass()
    
    /* Variables */
    
    var totalAmount = 0.00, totalAmountPerPerson = 0.00, tipAmount = 0.0, billAmount = 0.00, tipRate = 0.0, taxAmount = 0.00, displayedTotalAmountPerPerson = 0.0,moreOrLessPerPerson = 0.00
    
    var localSalesTax = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.double(forKey: "userLocalSalesTax"))!
    
    var numberOfPeoplePaying = 1
    
    var selectedVenue = "Quick"
    
    // Individual Venue w/ Tip Dictionary
    
    var quickTipArray = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.array(forKey: "quickTipArray")) as! [Double]
    
    var barTipArray = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.array(forKey: "barTipArray")) as! [Double]
    
    //var casinoTipArray = (NSUserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.arrayForKey("casinoTipArray")) as [Double]
    
    var diningTipArray = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.array(forKey: "diningTipArray")) as! [Double]
    
    var salonTipArray = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.array(forKey: "salonTipArray")) as! [Double]
    
    var taxiTipArray = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.array(forKey: "taxiTipArray")) as! [Double]
    
    var deliveryTipArray = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.array(forKey: "deliveryTipArray")) as! [Double]
    
    
    var venuesAndTipsDictionary: [String: [Double]]!
    
    
    var tipRateArray = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.array(forKey: "quickTipArray"))as! [Double]
    
    var arrayOfButtonsPressedForBillAmountAsString: [String] = []
    var arrayOfButtonsPressedForTaxAmountAsString: [String] = []
    var arrayOfButtonsPressedForTipRateAsString: [String] = []
    var arrayOfButtonsPressedForNumberOfPeoplePayingAsString: [String] = []
    
    var firstResponderTag = 0
    
    init() {
        
        venuesAndTipsDictionary = [/*"None": [0.0, 0.0, 0.0],*/ "Quick": quickTipArray, NSLocalizedString("Bar", comment: "Bar"): barTipArray, /*"Casino": casinoTipArray,*/ NSLocalizedString("Dining", comment: "Dining"): diningTipArray, NSLocalizedString("Salon", comment: "Salon"): salonTipArray, NSLocalizedString("Taxi", comment: "Taxi"): taxiTipArray, NSLocalizedString("Delivery", comment: "Delivery"): deliveryTipArray]
        
    }
    
    
    /* Functions */
    
    func calculate(_ arrayOfPressedButtonValues: [String], sentFirstResponderTag: Int){
        
        
        var inputAmount = 0.00
        
        if !arrayOfPressedButtonValues.isEmpty {
            
            inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
            
        } else {
            
            inputAmount = 0.00
            
        }
        
        checkResponderStatus(inputAmount, firstResponderTag: sentFirstResponderTag)
    }
    
    func display(_ arrayOfPressedButtonValues: [String], sentFirstResponderTag: Int) {
        
        var inputAmount = 1.0
        
        if !arrayOfPressedButtonValues.isEmpty {
            
            inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
            
        } else {
            
            inputAmount = 1.0
        }
        
        if inputAmount == 0.0 {
            
            inputAmount = 1.0
            
        }
        
        checkResponderStatus(inputAmount, firstResponderTag: sentFirstResponderTag)
        
    }
    
    func userDefinedTipRatings (_ arrayOfPressedButtonValues: [String], venueToEdit: String, tipRateToEdit: Int) {
        
        var inputAmount = 0.00
        
        if !arrayOfPressedButtonValues.isEmpty {
            
            inputAmount = NumberFormatter().number(from: arrayOfPressedButtonValues.joined(separator: "")) as! Double * 0.01
            
        } else {
            
            inputAmount = 0.00
            
        }
        
        
        // 0 = Poor
        // 1 = Average
        // 2 = Great
        
        if tipRateToEdit >= 0 && tipRateToEdit <= 2 {
            
            if venueToEdit == "Dining" {
                
                diningTipArray[tipRateToEdit] = inputAmount * 0.01
                
            } else if venueToEdit == "Bar" {
                
                barTipArray[tipRateToEdit] = inputAmount * 0.01
                
            } else if venueToEdit == "Quick" {
                
                quickTipArray[tipRateToEdit] = inputAmount * 0.01
                
            } else if venueToEdit == "Taxi" {
                
                taxiTipArray[tipRateToEdit] = inputAmount * 0.01
                
            } else if venueToEdit == "Salon" {
                
                salonTipArray[tipRateToEdit] = inputAmount * 0.01
                
            } /*else if venueToEdit == "Casino" {
                 
                 casinoTipArray[tipRateToEdit] = inputAmount * 0.01
                 
             }*/ else if venueToEdit == "Delivery" {
                
                deliveryTipArray[tipRateToEdit] = inputAmount * 0.01
                
            }
            
        }
        
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.setValue(diningTipArray, forKey: "diningTipArray")
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.setValue(barTipArray, forKey: "barTipArray")
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.setValue(taxiTipArray, forKey: "taxiTipArray")
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.setValue(salonTipArray, forKey: "salonTipArray")
        //NSUserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.setValue(casinoTipArray, forKey: "casinoTipArray")
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.setValue(quickTipArray, forKey: "quickTipArray")
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.setValue(deliveryTipArray, forKey: "deliveryTipArray")
        
    }
    
    func checkResponderStatus(_ inputAmount: Double, firstResponderTag: Int) {
        
        switch firstResponderTag {
            
        case 1:
            
            billAmount = inputAmount
            
            useTaxAmount(false)
            
        case 2:
            
            taxAmount = inputAmount
            
            useTaxAmount(true)
            
        case 3:
            
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
            
        case 4:
            
            tipRate = inputAmount * 0.01
            
            
        case 5:
            
            localSalesTax = inputAmount * 0.001
            
            
        default:
            
            break
            
        }
        
    }
    
    func useTaxAmount(_ doEditTaxAmount: Bool) {
        
        var locallyCalculatedTaxAmount = billAmount * localSalesTax
        
        if (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.double(forKey: "userLocalSalesTax")) != 0.0 {
            
            locallyCalculatedTaxAmount = billAmount * localSalesTax
            
        }
        
        if doEditTaxAmount != true {
            
            taxAmount = locallyCalculatedTaxAmount
            
        }
        
    }
    
    
    func updateValues() -> (formattedBillAmount: String, formattedTaxAmount: String, formattedTipRate: String, numberOfPeoplePaying: String, tipAmount: String, totalAmount: String, totalAmountPerPerson: String) {
        
        venuesAndTipsDictionary = [/*"None": [0.0, 0.0, 0.0],*/ "Quick": quickTipArray, NSLocalizedString("Bar", comment: "Bar"): barTipArray, /*"Casino": casinoTipArray,*/ NSLocalizedString("Dining", comment: "Dining"): diningTipArray, NSLocalizedString("Salon", comment: "Salon"): salonTipArray, NSLocalizedString("Taxi", comment: "Taxi"): taxiTipArray, NSLocalizedString("Delivery", comment: "Delivery"): deliveryTipArray]
        
        
        tipAmount = (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")!.bool(forKey: "tipIncludeTaxSwitchOnOff") ? (billAmount + taxAmount) * tipRate : billAmount * tipRate)
        
        
        totalAmount = billAmount + tipAmount + taxAmount
        
        totalAmountPerPerson = totalAmount / Double(numberOfPeoplePaying)
        
        if UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "roundTipAmountSwitchOnOff") == true {
            
            tipAmount = ceil(tipAmount)
            
            totalAmount = billAmount + tipAmount + taxAmount
            
            totalAmountPerPerson = totalAmount / Double(numberOfPeoplePaying)
            
        }
        
        if UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "roundTotalAmountSwitchOnOff") == true {
            
            
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
        
        selectedVenue = "Quick"
        
        tipRateArray = venuesAndTipsDictionary[selectedVenue]!
        
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
