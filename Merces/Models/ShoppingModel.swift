//
//  ShoppingModel.swift
//  Merces
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import Foundation

class ShoppingModel {
    
    let numberFormattingObject = NumberFormattingClass()
    
    var subtotal: Double
    var taxAmount: Double
    
    var totalAmount: Double
    
    init() {
        subtotal = 0.0
        taxAmount = 0.0
        
        totalAmount = 0.0
    }
    
    func computeValues() -> (formattedBillAmount: String, formattedTaxAmount: String) {
        
        totalAmount = subtotal + taxAmount
        
        return (numberFormattingObject.roundForCurrency(number: subtotal), numberFormattingObject.roundForCurrency(number: taxAmount))
    }
}
