//
//  CalculationsModel.swift
//  Merces
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import Foundation

enum ServiceQuality {
    case Poor
    case Average
    case Great
}

enum EditableTextFields: CaseIterable, Hashable, Identifiable {
    case subtotal
    case salesTax
    case numPeople
    case tipRate
    case venue
    case none
    
    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }
    
    var id: EditableTextFields { self }
}

/* First Responder Tags
 * 1 = Subtotal / Bill Amount
 * 2 = Sales Tax / Tax Amount
 * 3 = Number of People Paying
 * 4 = Tip Rate
 * 5 = Sales Tax
 */

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
    
    var selectedVenue: VenueType
    var service: ServiceQuality
    
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
        self.tipRate = 0.00
        
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
        self.tipAmount = 0.0
        
        self.displayedTotalAmountPerPerson = 0.0
        self.moreOrLessPerPerson = 0.00
    }
    
    /// Replaces the updateValues method formerly found in VariableAmountsClass
    func computeTippingValues() -> (formattedBillAmount: String, formattedTaxAmount: String, formattedTipRate: String, numberOfPeoplePaying: String, tipAmount: String, totalAmount: String, totalAmountPerPerson: String) {
        
        self.objectWillChange.send()
        
        tipAmount = (mUserDefaults!.bool(forKey: "tipIncludeTaxSwitchOnOff") ? (subtotal + taxAmount) * (tipRate) : subtotal * (tipRate))
        
        totalAmount = subtotal + tipAmount + taxAmount
        
        totalAmountPerPerson = totalAmount / Double(partySize)
        
        if mUserDefaults!.bool(forKey: "roundTipAmountSwitchOnOff") {
            tipAmount = ceil(tipAmount)
            
            totalAmount = subtotal + tipAmount + taxAmount
            
            totalAmountPerPerson = totalAmount / Double(partySize)
        }
        
        if mUserDefaults!.bool(forKey: "roundTotalAmountSwitchOnOff") {
            totalAmount = ceil(subtotal + tipAmount + taxAmount)
            
            totalAmountPerPerson = ceil(totalAmount / Double(partySize))
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
