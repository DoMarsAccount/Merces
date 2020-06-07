//
//  ShoppingModel.swift
//  Merces
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import Foundation

class ShoppingModel {
    enum EditableFields {
        case subtotal
        case salesTax
        case none
    }
    
    var billAmount: Double
    var taxAmount: Double
    
    init() {
        billAmount = 0.0
        taxAmount = 0.0
    }
}
