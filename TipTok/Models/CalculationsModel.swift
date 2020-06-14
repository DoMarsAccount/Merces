//
//  CalculationsModel.swift
//  TipTok
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import Foundation

class CalculationsModel: ObservableObject {
    
    @Published var subtotal: Double {
           didSet {
               _ = computeTippingValues()
           }
       }
    @Published var taxAmount: Double {
           didSet {
               _ = computeTippingValues()
           }
       }
    @Published var tipRate: Double {
        didSet {
            _ = computeTippingValues()
        }
    }
    @Published var partySize: Int {
        didSet {
            _ = computeTippingValues()
        }
    }
    
    @Published var tipAmount: Double
    @Published var totalAmount: Double
    @Published var totalAmountPerPerson: Double
    
    @Published var selectedVenue: VenueType {
        didSet {
            tipRate = currentTipRate(for: selectedVenue, service: service)
        }
    }
    @Published var service: ServiceQuality {
        didSet {
            tipRate = currentTipRate(for: selectedVenue, service: service)
        }
    }
    
    var displayedTotalAmountPerPerson: Double
    var moreOrLessPerPerson: Double
    
    init() {
        self.subtotal = 0.00
        self.taxAmount = 0.00
        self.tipAmount = 0.0
        self.partySize = 1
        
        self.totalAmount = 0.0
        self.totalAmountPerPerson = 0.0
        
        self.selectedVenue = .quick
        self.service = .Average
        self.tipRate = tipRates(for: .quick)[1]
        
        self.displayedTotalAmountPerPerson = 0.0
        self.moreOrLessPerPerson = 0.00
    }
    
    func resetValues() {
        self.subtotal = 0.00
        self.taxAmount = 0.00
        self.tipRate = 0.00
        self.partySize = 1
        
        self.totalAmount = 0.0
        self.totalAmountPerPerson = 0.0
        
        self.selectedVenue = .quick
        self.service = .Average
        self.tipRate = tipRates(for: self.selectedVenue)[1]
        
        self.displayedTotalAmountPerPerson = 0.0
        self.moreOrLessPerPerson = 0.00
    }
    
    /// Replaces the updateValues method formerly found in VariableAmountsClass
    func computeTippingValues() -> (formattedBillAmount: String, formattedTaxAmount: String, formattedTipRate: String, numberOfPeoplePaying: String, tipAmount: String, totalAmount: String, totalAmountPerPerson: String) {
        
        self.objectWillChange.send()
        
//        if userPrefs.subtotalIsPostTax {
//            subtotal = subtotal / (1 + userPrefs.localSalesTax)
//            taxAmount = subtotal * userPrefs.localSalesTax
//        }
        
        tipAmount = (UserPreferences.sharedInstance.tipIncludeTax ? (subtotal + taxAmount) * (tipRate) : subtotal * (tipRate))
        totalAmount = subtotal + tipAmount + taxAmount
        totalAmountPerPerson = totalAmount / Double(partySize)
        
        if UserPreferences.sharedInstance.roundTipAmount {
            tipAmount = ceil(tipAmount)
            totalAmount = subtotal + tipAmount + taxAmount
            totalAmountPerPerson = totalAmount / Double(partySize)
        }
        
        if UserPreferences.sharedInstance.roundTotalAmount {let difference = ceil(subtotal + tipAmount + taxAmount) - totalAmount
            tipAmount += difference // Add the required difference to the tipAmount so that totalAmount will be a round number
            totalAmount = subtotal + tipAmount + taxAmount
            totalAmountPerPerson = totalAmount / Double(partySize)
        }
        
        // Checks for repeating decimal in the tip per person
        // if value is > 0, it will be rounded upward, meaning not all need to pay "extra"
        // else value is rounded down, meaning some need to pay a little more
        
        if ("$\(totalAmountPerPerson.roundTo(places: 2))" == nForm.roundForCurrency(number: totalAmountPerPerson)) && ("$\(totalAmountPerPerson.roundTo(places: 2) * Double(partySize))" == nForm.roundForCurrency(number: totalAmount)){
            
            moreOrLessPerPerson = 0
            
        } else if partySize > 1 {
            moreOrLessPerPerson = ((totalAmountPerPerson * Double(partySize)) - (totalAmountPerPerson.roundTo(places: 2) * Double(partySize))) * 100
            
        } else {
            moreOrLessPerPerson = 0
        }
        
        return (nForm.roundForCurrency(number: subtotal), nForm.roundForCurrency(number: taxAmount), nForm.roundForPercentWithTwoDecimalPlaces(tipRate),"\(partySize)", nForm.roundForCurrency(number: tipAmount), nForm.roundForCurrency(number: totalAmount), nForm.roundForCurrency(number: totalAmountPerPerson))
    }
    
    func computeShoppingValues() -> (formattedBillAmount: String, formattedTaxAmount: String, formattedTotalAmount: String) {
        
        totalAmount = subtotal + taxAmount
        
        return (nForm.roundForCurrency(number: subtotal), nForm.roundForCurrency(number: taxAmount), nForm.roundForCurrency(number: totalAmount))
    }

}
