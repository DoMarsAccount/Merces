//
//  CalculationsModel.swift
//  TipTok
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import Foundation

class CalculationsModel: ObservableObject {
    static let sharedInstance = CalculationsModel()
    private var venues = Venues.sharedInstance
    private var manuallyUpdatingTaxAmount: Bool = false
    
    @Published var subtotal: Double {
       didSet {
           _ = computeTippingValues()
       }
    }
    @Published var taxAmount: Double {
        didSet {
            if !self.manuallyUpdatingTaxAmount {
                _ = computeTippingValues()
            }
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
    
    @Published var selectedVenue: Venue {
        didSet {
            tipRate = venues.currentTipRate(for: selectedVenue, service: service)!
        }
    }
    @Published var service: ServiceQuality {
        didSet {
            tipRate = venues.currentTipRate(for: selectedVenue, service: service)!
        }
    }
    
    var displayedTotalAmountPerPerson: Double
    var moreOrLessPerPerson: Double
    
    private init() {
        self.subtotal = 0.00
        self.taxAmount = 0.00
        self.tipAmount = 0.0
        self.partySize = 1
        
        self.totalAmount = 0.0
        self.totalAmountPerPerson = 0.0
        
        self.selectedVenue = venues.selectedVenue
        self.service = .Good
        self.tipRate = 0.00
//        self.tipRate = venues.currentTipRate(for: venues.selectedVenue, service: .Good)!
        
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
        
        self.selectedVenue = venues.selectedVenue
        self.service = .Good
        self.tipRate = 0.00
//        self.tipRate = venues.currentTipRate(for: venues.selectedVenue, service: .Good)!
        
        self.displayedTotalAmountPerPerson = 0.0
        self.moreOrLessPerPerson = 0.00
    }
    
    /// Replaces the updateValues method formerly found in VariableAmountsClass
    func computeTippingValues() {
        var mathTaxAmount = taxAmount
        if !UserPreferences.sharedInstance.subtotalIsPostTax {
            // Check if user entered a local sales tax
            if UserPreferences.sharedInstance.localSalesTax != 0.0 {
                mathTaxAmount = subtotal * UserPreferences.sharedInstance.localSalesTax
                self.manuallyUpdatingTaxAmount = true
                taxAmount = mathTaxAmount
                self.manuallyUpdatingTaxAmount = false
            }
        } else {
            mathTaxAmount = 0.0
        }
        
        tipAmount = (UserPreferences.sharedInstance.tipIncludeTax ? (subtotal + mathTaxAmount) * (tipRate) : subtotal * (tipRate))
        totalAmount = subtotal + tipAmount + mathTaxAmount
        totalAmountPerPerson = totalAmount / Double(partySize)
        
        if UserPreferences.sharedInstance.roundTipAmount {
            tipAmount = ceil(tipAmount)
            totalAmount = subtotal + tipAmount + mathTaxAmount
            totalAmountPerPerson = totalAmount / Double(partySize)
        }
        
        if UserPreferences.sharedInstance.roundTotalAmount {let difference = ceil(subtotal + tipAmount + mathTaxAmount) - totalAmount
            tipAmount += difference // Add the required difference to the tipAmount so that totalAmount will be a round number
            totalAmount = subtotal + tipAmount + mathTaxAmount
            totalAmountPerPerson = totalAmount / Double(partySize)
        }
        
        // Checks for repeating decimal in the tip per person
        // if value is > 0, it will be rounded upward, meaning not all need to pay "extra"
        // else value is rounded down, meaning some need to pay a little more
        
        if ("$\(totalAmountPerPerson.roundTo(places: 2))" == nForm.roundForCurrency(number: totalAmountPerPerson)) && ("$\(totalAmountPerPerson.roundTo(places: 2) * Double(partySize))" == nForm.roundForCurrency(number: totalAmount)){
            
            moreOrLessPerPerson = 0
            
        } else if partySize > 1 {
            moreOrLessPerPerson = ((totalAmountPerPerson * Double(partySize)) - (totalAmountPerPerson.roundTo(places: 2) * Double(partySize))) * 100
            
            if moreOrLessPerPerson > 0 {
                totalAmountPerPerson += 0.01
            }
            
        } else {
            moreOrLessPerPerson = 0
        }
    }
    
    func computeShoppingValues() -> (formattedBillAmount: String, formattedTaxAmount: String, formattedTotalAmount: String) {
        
        totalAmount = subtotal + taxAmount
        
        return (nForm.roundForCurrency(number: subtotal), nForm.roundForCurrency(number: taxAmount), nForm.roundForCurrency(number: totalAmount))
    }

}
