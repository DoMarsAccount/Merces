//
//  ReceiptModel.swift
//  TipTok
//
//  Created by Donovan McCray on 6/1/20.
//  Copyright © 2020 Donovan McCray. All rights reserved.
//

import Foundation

class ReceiptModel {
    var name: String
    var time: TimeInterval
    let savedCalculations: CalculationsModel
    
    init(calculations: CalculationsModel) {
        name = "Lorem Ipsum"
        time = 5.0
        savedCalculations = calculations
    }
}
