//
//  ThemesInterfaceController.swift
//  merces
//
//  Created by Donovan McCray on 3/8/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit
import Foundation


class ThemesInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var mainColorOutlet: WKInterfaceButton!
    @IBOutlet var secondaryColorOutlet: WKInterfaceButton!
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        setTitle(NSLocalizedString("Themes", comment: "Themes"))
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
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        
        if segueIdentifier == "changeMainColor" {
            
            return "changeMainColor"
            
        } else if segueIdentifier == "changeTextColor" {
            
            return "changeTextColor"
            
        }
        
        return nil
    }
    
    func updateColorValues() {
        
        mainColorOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        mainColorOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("MainColor", comment: "Main Color"), attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
        
        
        secondaryColorOutlet.setBackgroundColor(coloringThemes.getSecondaryColorForWatch())
        secondaryColorOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("SecondaryColor", comment: "Secondary Color"), attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getSecondaryColorForWatch(), isFlat: true)]))
        
        
    }

}
