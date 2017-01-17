//
//  TotaledAmountsInterfaceController.swift
//  merces
//
//  Created by Donovan McCray on 2/23/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit
import Foundation

class TotaledAmountsInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var totaledTipAmount: WKInterfaceLabel!
    
    @IBOutlet var totaledTotalPerPerson: WKInterfaceLabel!
    
    @IBOutlet var totaledTotalAmount: WKInterfaceLabel!
    
    @IBOutlet var tipAmountHeadlineOutlet: WKInterfaceLabel!
    
    @IBOutlet var totalAmountPerPersonHeadlineOutlet: WKInterfaceLabel!
    
    @IBOutlet var totalAmountHeadlineOutlet: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle(NSLocalizedString("TotaledAmounts", comment: "Totaled Amounts"))
    
    }

    override func willActivate() {
        super.willActivate()

        updateColorValues()
        
    }

    override func didDeactivate() {
        super.didDeactivate()
        
        
        
    }
    
    func updateColorValues() {
        
        totaledTipAmount.setAttributedText(NSAttributedString(string: varAmountsObject.updateValues().tipAmount, attributes: [NSForegroundColorAttributeName: coloringThemes.textColor2]))
        
        totaledTotalAmount.setAttributedText(NSAttributedString(string: varAmountsObject.updateValues().totalAmount, attributes: [NSForegroundColorAttributeName: coloringThemes.textColor2]))
        
        totaledTotalPerPerson.setAttributedText(NSAttributedString(string: varAmountsObject.updateValues().totalAmountPerPerson, attributes: [NSForegroundColorAttributeName: coloringThemes.textColor2]))
        
        
        
        totalAmountHeadlineOutlet.setAttributedText(NSAttributedString(string: "Grand Total: ", attributes: [NSForegroundColorAttributeName: UIColor.white]))
        
        totalAmountPerPersonHeadlineOutlet.setAttributedText(NSAttributedString(string: "Total Amount (per person):", attributes: [NSForegroundColorAttributeName: UIColor.white]))
        
        tipAmountHeadlineOutlet.setAttributedText(NSAttributedString(string: "Tip Amount:", attributes: [NSForegroundColorAttributeName: UIColor.white]))
        
    }

}
