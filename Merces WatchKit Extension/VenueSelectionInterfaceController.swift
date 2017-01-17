//
//  VenueSelectionInterfaceController.swift
//  merces
//
//  Created by Donovan McCray on 3/4/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit
import Foundation


class VenueSelectionInterfaceController: WKInterfaceController {
    
    @IBOutlet var venueTable: WKInterfaceTable!
    
    
    
    let venues = Array(varAmountsObject.venuesAndTipsDictionary.keys)

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        setTitle(NSLocalizedString("Venue", comment: "Venue"))
        
        self.venueTable.setNumberOfRows(venues.count, withRowType: "VenueRow")
        
        for i in 0 ..< venues.count {
            
            let row = self.venueTable.rowController(at: i) as! VenueAndServiceSelection
            
            row.venueButtonOutlet.setTitle(venues[i])
            
        }
        
    }

    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        
        if segueIdentifier == "VenueServiceRatings" {
            
            let venue = venues[rowIndex]
            
            let arrayOfServiceRatings = varAmountsObject.venuesAndTipsDictionary[venue]!
            
            return [venue: arrayOfServiceRatings]
            
        }
        
        return nil
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        updateColorValues()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        
        
    }
    
    func updateColorValues() {
        
        for i in 0 ..< venues.count {
            
            let row = self.venueTable.rowController(at: i) as! VenueAndServiceSelection
            
            row.venueButtonOutlet.setAttributedTitle(NSAttributedString(string: venues[i], attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
            
            row.venueButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
            
            row.groupOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
            
        }
        
    }
    

}
