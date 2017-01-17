//
//  SettingsInterfaceController.swift
//  merces
//
//  Created by Donovan McCray on 2/22/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit
import Foundation


var totalAmountSwitchState = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "roundTotalAmountSwitchOnOff")

var tipAmountSwitchState = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "roundTipAmountSwitchOnOff")

var tipIncludesTaxSwitchState = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "tipIncludeTaxSwitchOnOff")


// ========================== Class Begins ===================== //

class SettingsInterfaceController: WKInterfaceController {
    
    @IBOutlet var tipIncludesTaxSwitch: WKInterfaceSwitch!
    @IBOutlet var totalAmountSwitch: WKInterfaceSwitch!
    @IBOutlet var tipAmountSwitch: WKInterfaceSwitch!
    
    @IBOutlet var generalHeadlineOutlet: WKInterfaceLabel!
    @IBOutlet var roundUpToNearestDollarHeadlineOutlet: WKInterfaceLabel!
    
    @IBOutlet var themesButtonOutlet: WKInterfaceButton!
    
    
    
    
//    override func awake(withContext context: Any?) {
//        super.awake(withContext: context)
//        
//        setTitle(NSLocalizedString("Settings", comment: "Settings"))
//        
//        MMObject.listenForMessageWithIdentifier("updateiWatchSettings", listener: {(listener) -> Void in
//                
//            if let totalAmountMessage: AnyObject = MMObject.messageWithIdentifier("updateiWatchSettings").valueForKey("totalAmountSwitchChanged") {
//                
//                self.totalAmountSwitch.setOn(totalAmountMessage as! Bool)
//                
//                totalAmountSwitchState = totalAmountMessage as? Bool
//                
//            } else if let tipAmountMessage: AnyObject = MMObject.messageWithIdentifier("updateiWatchSettings").valueForKey("tipAmountSwitchChanged") {
//                
//                self.tipAmountSwitch.setOn(tipAmountMessage as! Bool)
//                
//                tipAmountSwitchState = tipAmountMessage as? Bool
//                
//            } else if let tipIncludesTaxMessage: AnyObject = MMObject.messageWithIdentifier("updateiWatchSettings").valueForKey("tipIncludesTaxSwitchChanged") {
//                
//                
//                self.tipIncludesTaxSwitch.setOn(tipIncludesTaxMessage as! Bool)
//                
//                tipIncludesTaxSwitchState = tipIncludesTaxMessage as? Bool
//                
//            }
//            
//        })
//        
//        
//    }
    
    override func willActivate() {
        super.willActivate()
        
        updateColorValues()
        
        totalAmountSwitch.setOn(totalAmountSwitchState!)
        
        
        tipAmountSwitch.setOn(tipAmountSwitchState!)
        
        
        tipIncludesTaxSwitch.setOn(tipIncludesTaxSwitchState!)
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(totalAmountSwitchState!, forKey: "roundTotalAmountSwitchOnOff")
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(tipAmountSwitchState!, forKey: "roundTipAmountSwitchOnOff")
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(tipIncludesTaxSwitchState!, forKey: "tipIncludeTaxSwitchOnOff")
        
        
    }
    
    @IBAction func tipIncludesTaxSwitchAction(_ value: Bool) {
        
        
        MMObject.passMessageObject(["tipIncludesTaxSwitchChanged":value], identifier: "updateiPhoneSettings")
            
        
        tipIncludesTaxSwitchState = value
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(tipIncludesTaxSwitchState!, forKey: "tipIncludeTaxSwitchOnOff")
    }
    
    @IBAction func roundUpTotalAmountSwitchAction(_ value: Bool) {
        
        MMObject.passMessageObject(["totalAmountSwitchChanged":value], identifier: "updateiPhoneSettings")
        
        totalAmountSwitchState = value
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(totalAmountSwitchState!, forKey: "roundTotalAmountSwitchOnOff")
    }
    
    
    @IBAction func roundUpTipAmountSwitchAction(_ value: Bool) {
        
        MMObject.passMessageObject(["tipAmountSwitchChanged":value], identifier: "updateiPhoneSettings")
            
        tipAmountSwitchState = value
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(tipAmountSwitchState!, forKey: "roundTipAmountSwitchOnOff")
        
    }
    
    func updateColorValues() {
    
        generalHeadlineOutlet.setAttributedText(NSAttributedString(string: NSLocalizedString("General", comment: "General"), attributes: [NSForegroundColorAttributeName: UIColor.white]))
        
        roundUpToNearestDollarHeadlineOutlet.setAttributedText(NSAttributedString(string: NSLocalizedString("RoundUp", comment: "Round Up to Nearest Dollar"), attributes: [NSForegroundColorAttributeName: UIColor.white]))
        
        
        
        themesButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        
        themesButtonOutlet.setAttributedTitle(NSAttributedString(string: NSLocalizedString("Themes", comment: "Themes"), attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
        
    }
    
}
