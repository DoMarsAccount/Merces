//
//  PopToRootControllerInterfaceController.swift
//  merces
//
//  Created by Donovan McCray on 3/4/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit
import Foundation


class PopToRootControllerInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if let passedChosenServiceRating = context as? Double {
                
            varAmountsObject.calcModel.tipRate = passedChosenServiceRating
            
//            MMObject.passMessageObject(["chosenServiceRating": passedChosenServiceRating], identifier: "updateiPhoneView")
            
                
            popToRootController()
            
        } else if let passedChosenColorAndColorToChange = context as? [UIColor: String] {
            
            if passedChosenColorAndColorToChange.values.array[0] == "changeMainColor" {
                
                UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set("\(passedChosenColorAndColorToChange.keys.array[0])", forKey: "watchMainColor")
                
            } else if passedChosenColorAndColorToChange.values.array[0] == "changeTextColor" {
                
                UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set("\(passedChosenColorAndColorToChange.keys.array[0])", forKey: "watchTextColor")
                
            }
            
            pop()
            
        }
        
        //popToRootController()
        
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
