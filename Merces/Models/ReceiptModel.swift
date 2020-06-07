//
//  ReceiptModel.swift
//  Merces
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import Foundation

class ReceiptModel {
    var subtotal: Double
    var taxAmount: Double
    
    var partySize: Int
    var venue: VenueType
    var tipRate: Double
    
    init(billAmt: Double, taxAmt: Double, numPeople: Int, venue: VenueType, tip: Double) {
        self.subtotal = billAmt
        self.taxAmount = taxAmt
        self.partySize = numPeople
        self.venue = venue
        self.tipRate = tip
    }
}
