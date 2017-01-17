//
//  ServiceRatingsInterfaceController.swift
//  merces
//
//  Created by Donovan McCray on 3/4/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit
import Foundation


class ServiceRatingsInterfaceController: WKInterfaceController {
    
    @IBOutlet var serviceTable: WKInterfaceTable!
    
    var arrayOfServiceRatings = []

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        setTitle(NSLocalizedString("ServiceRating", comment: "Service Rating"))
        
        if let passedArrayOfServiceRatings = context as? [String: [Double]] {
            
            self.arrayOfServiceRatings = passedArrayOfServiceRatings.values.array[0]
            
            MMObject.passMessageObject(["chosenVenue": passedArrayOfServiceRatings.keys.array[0]], identifier: "updateiPhoneView")
            
        }
        
        self.serviceTable.setNumberOfRows(arrayOfServiceRatings.count, withRowType: "ServiceRow")
        
        for i in 0 ..< arrayOfServiceRatings.count {
            
            let row = self.serviceTable.rowController(at: i) as! VenueAndServiceSelection
            
            row.serviceButtonOutlet.setTitle(watchNmbrFormattingObject.roundForPercentWithDecimalPlace(arrayOfServiceRatings[i] as! Double))
            
            
        }
        
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        
        if segueIdentifier == "ServiceRatingChosen" {
            
            let chosenServiceRating = self.arrayOfServiceRatings[rowIndex] as! Double
            
            return chosenServiceRating
            
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
        
        for i in 0 ..< arrayOfServiceRatings.count {
            
            let row = self.serviceTable.rowController(at: i) as! VenueAndServiceSelection
            
            row.serviceButtonOutlet.setAttributedTitle(NSAttributedString(string: watchNmbrFormattingObject.roundForPercentWithDecimalPlace(arrayOfServiceRatings[i] as! Double), attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
            
            row.serviceButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
            
            row.serviceGroupOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
            
        }
        
    }

}
