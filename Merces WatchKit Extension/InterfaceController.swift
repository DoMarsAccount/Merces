//
//  InterfaceController.swift
//  Merces WatchKit Extension
//
//  Created by Donovan McCray on 3/31/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit
import Foundation
//import ChameleonFramework

/* Objects */

let coloringThemes = ColoringAndThemes()

let varAmountsObject = VariableAmountsClass()

let watchNmbrFormattingObject = NumberFormattingClass()


/* Etc */

var firstResponderValue = 0

/* Class Begins */


class InterfaceController: WKInterfaceController {

    /* Outlets */
    
    @IBOutlet var billAmountWatchButtonOutlet: WKInterfaceButton!
    
    @IBOutlet var taxAmountWatchButtonOutlet: WKInterfaceButton!
    
    @IBOutlet var tipRateWatchButtonOutlet: WKInterfaceButton!
    
    @IBOutlet var numberOfPeopleWatchButtonOutlet: WKInterfaceButton!
    
    @IBOutlet var venueAndServiceWatchButtonOutlet: WKInterfaceButton!
    
    @IBOutlet var totaledValuesWatchButtonOutlet: WKInterfaceButton!
    
    
    @IBAction func launchSettings() {
        
        pushController(withName: "SettingsController", context: nil)
        
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle("Merces")
        
        // Open Parent Application is called just to ensure that the iPhone app is running in the background
        
        WKInterfaceController.openParentApplication([:], reply: {(error, reply) -> Void in
            
            
        })
        
        /* ------------ Set up Default Values ------------- */
        let defaultPrefsFile = Bundle.main.path(forResource: "defaultPreferences", ofType: "plist")
        
        let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile!)
        
        (UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.register(defaults: defaultPreferences! as! [AnyHashable : Any] as [AnyHashable: Any] as! [String : Any]))
        
        
        
        
        varAmountsObject.tipRateArray = varAmountsObject.venuesAndTipsDictionary[varAmountsObject.selectedVenue]!
        
        varAmountsObject.tipRate = varAmountsObject.tipRateArray[1]
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        updateFieldValues()
        
        updateColorValues()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        
        if segueIdentifier == "billAmountSegue" {
            
            firstResponderValue = 1
            
        } else if segueIdentifier == "taxAmountSegue" {
            
            firstResponderValue = 2
            
        } else if segueIdentifier == "tipRateSegue" {
            
            firstResponderValue = 4
            
        } else if segueIdentifier == "numberOfPeopleSegue" {
            
            firstResponderValue = 3
            
        } else {
            
            firstResponderValue = 0
            
        }
        
        return firstResponderValue
    }
    
    func updateFieldValues() {
        
        billAmountWatchButtonOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("Subtotal", comment: "Subtotal") + ": \(varAmountsObject.updateValues().formattedBillAmount)", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
        
        taxAmountWatchButtonOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("SalesTax", comment: "Sales Tax") + ": \(varAmountsObject.updateValues().formattedTaxAmount)", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
        
        tipRateWatchButtonOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("TipRate", comment: "Tip Rate") + ": \(varAmountsObject.updateValues().formattedTipRate)", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
        
        numberOfPeopleWatchButtonOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("NumberOfPeople", comment: "# of people") + ": \(varAmountsObject.updateValues().numberOfPeoplePaying)", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
        
        venueAndServiceWatchButtonOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("VenueAndService", comment: "Venue and Service"), attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
        
        totaledValuesWatchButtonOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("TotaledAmounts", comment: "Totaled Amounts"), attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getSecondaryColorForWatch(), isFlat: true)]))
        
        
        //NSUserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.setObject(colorData, forKey: "backgroundColor")
        
    }
    
    func updateColorValues() {
        
        
        billAmountWatchButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        
        taxAmountWatchButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        
        tipRateWatchButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        
        numberOfPeopleWatchButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        
        venueAndServiceWatchButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        
        totaledValuesWatchButtonOutlet.setBackgroundColor(coloringThemes.getSecondaryColorForWatch())
        
        
    }

}
