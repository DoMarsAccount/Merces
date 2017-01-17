//
//  ChangeUsedColorsInterfaceController.swift
//  merces
//
//  Created by Donovan McCray on 3/9/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit


class ChangeUsedColorsInterfaceController: WKInterfaceController {
    
    @IBOutlet var colorTableOutlet: WKInterfaceTable!
    
    let arrayOfColors = coloringThemes.arrayOfAllColors
    
    var colorToChange = "None"

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let changeMainOrTextColor = context as? String {
            
            colorToChange = changeMainOrTextColor
            
            if colorToChange == "changeMainColor" {
                
                setTitle(NSLocalizedString("MainColor", comment: "Main Color"))
                
            } else if colorToChange == "changeTextColor" {
                
                setTitle(NSLocalizedString("SecondaryColor", comment: "Secondary Color"))
                
            }
            
        }
        
        self.colorTableOutlet.setNumberOfRows((arrayOfColors?.count)!, withRowType: "ColorRow")
        
        for i in 0 ..< (arrayOfColors?.count)! {
            
            let row = self.colorTableOutlet.rowController(at: i) as! MainAndTextColorSelection
            
            row.colorButtonOutlet.setBackgroundColor(arrayOfColors?[i])
            
            //row.colorButtonOutlet.setTitle(coloringThemes.arrayOfAllColorNames[i])
            
            
            row.colorButtonOutlet.setAttributedTitle(NSAttributedString(string: coloringThemes.arrayOfAllColorNames[i], attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: arrayOfColors?[i], isFlat: true)]))
            
            
            
            row.colorGroupOutlet.setBackgroundColor(arrayOfColors?[i])
            
        }
        
    }
    
    
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        
        if segueIdentifier == "ColorChosen" {
            
            let chosenColor = (self.arrayOfColors?[rowIndex])! as UIColor
            
            return [chosenColor: colorToChange]
            
        }
        
        
        return nil
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
