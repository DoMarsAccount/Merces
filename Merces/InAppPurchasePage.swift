//
//  InAppPurchasePage.swift
//  Merces
//
//  Created by Donovan McCray on 6/1/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit
import StoreKit


class InAppPurchasePage: UIViewController {
    
    @IBOutlet var buttonOutlet: [UIButton]!
    
    @IBOutlet var textViewOutlet: UITextView!
    
    var product: SKProduct?
    
    var productID = "978591776"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateColorValues()

        for button in buttonOutlet {
            
            button.layer.cornerRadius = 2.5
            
            button.layer.borderWidth = 1
            
        }
        
        
        
    }
    
    @IBAction func restorePurchaseButtonPressed(_ sender: AnyObject) {
        
        
        
    }
    
    @IBAction func purchaseButtonPressed(_ sender: AnyObject) {
        
        
        
    }
    
    func updateColorValues() {
        
        self.view.backgroundColor = coloringThemes.getBackgroundColor()
        
        textViewOutlet.backgroundColor = coloringThemes.getBackgroundColor()
        
        //textViewOutlet.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
