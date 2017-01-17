//
//  WatchKeypadInterfaceController.swift
//  merces
//
//  Created by Donovan McCray on 2/22/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import WatchKit
import Foundation


class WatchKeypadInterfaceController: WKInterfaceController {
    
    var buttonsPressedArrayAsString: [String] = []
    
    @IBOutlet var amountValueWatchLabel: WKInterfaceLabel!
    
    @IBOutlet var oneButtonOutlet: WKInterfaceButton!
    @IBOutlet var twoButtonOutlet: WKInterfaceButton!
    @IBOutlet var threeButtonOutlet: WKInterfaceButton!
    @IBOutlet var fourButtonOutlet: WKInterfaceButton!
    @IBOutlet var fiveButtonOutlet: WKInterfaceButton!
    @IBOutlet var sixButtonOutlet: WKInterfaceButton!
    @IBOutlet var sevenButtonOutlet: WKInterfaceButton!
    @IBOutlet var eightButtonOutlet: WKInterfaceButton!
    @IBOutlet var nineButtonOutlet: WKInterfaceButton!
    @IBOutlet var zeroButtonOutlet: WKInterfaceButton!
    @IBOutlet var doneButtonOutlet: WKInterfaceButton!
    @IBOutlet var deleteButtonOutlet: WKInterfaceButton!
    
    
    
    
    
    
    /* Functions */

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if let firstResponder = context as? Int {
        
            switch firstResponder {
                
            case 1:
                
                setTitle(NSLocalizedString("Subtotal", comment: "Subtotal"))
                
            case 2:
                
                setTitle(NSLocalizedString("SalesTax", comment: "Sales Tax"))
                
            case 3:
                
                setTitle(NSLocalizedString("NumberOfPeople", comment: "# Of People"))
                
            case 4:
                
                setTitle(NSLocalizedString("TipRate", comment: "Tip Rate"))
                
            default:
                
                setTitle("")
                
            }
            
        }
        
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
    
    /* Functions */
    

    @IBAction func userPressedButton1() {
        
        buttonsPressedArrayAsString.append("1")
        
        calculate(buttonsPressedArrayAsString)
        
    }
    
    @IBAction func userPressedButton2() {
        
        buttonsPressedArrayAsString.append("2")
        
        calculate(buttonsPressedArrayAsString)
        
    }
    
    @IBAction func userPressedButton3() {
        
        buttonsPressedArrayAsString.append("3")
        
        calculate(buttonsPressedArrayAsString)
        
    }
    
    @IBAction func userPressedButton4() {
        
        buttonsPressedArrayAsString.append("4")
        
        calculate(buttonsPressedArrayAsString)
        
    }
    
    @IBAction func userPressedButton5() {
        
        buttonsPressedArrayAsString.append("5")
        
        calculate(buttonsPressedArrayAsString)
    }
    
    @IBAction func userPressedButton6() {
        
        buttonsPressedArrayAsString.append("6")
        
        calculate(buttonsPressedArrayAsString)
    }
    
    @IBAction func userPressedButton7() {
        
        buttonsPressedArrayAsString.append("7")
        
        calculate(buttonsPressedArrayAsString)
    }
    
    @IBAction func userPressedButton8() {
        
        buttonsPressedArrayAsString.append("8")
        
        calculate(buttonsPressedArrayAsString)
    }
    
    @IBAction func userPressedButton9() {
        
        buttonsPressedArrayAsString.append("9")
        
        calculate(buttonsPressedArrayAsString)
    }
    
    @IBAction func userPressedButton0() {
        
        buttonsPressedArrayAsString.append("0")
        
        calculate(buttonsPressedArrayAsString)
    }
    
    @IBAction func userPressedDeleteButton() {
        
        if !buttonsPressedArrayAsString.isEmpty {
            
            buttonsPressedArrayAsString.removeLast()
            
        }
        
        calculate(buttonsPressedArrayAsString)
        
    }
    
    @IBAction func userPressedDoneButton() {
        
        pop()
        
    }
    
    func calculate(_ arrayOfButtonsPressed: [String]) {
        
        if firstResponderValue == 3 {
            
            varAmountsObject.display(arrayOfButtonsPressed, sentFirstResponderTag: firstResponderValue)
            
            amountValueWatchLabel.setText(varAmountsObject.updateValues().numberOfPeoplePaying)
            
        } else {
            
            varAmountsObject.calculate(arrayOfButtonsPressed, sentFirstResponderTag: firstResponderValue)
            
        }
        
        if firstResponderValue == 1 {
            
            amountValueWatchLabel.setText(varAmountsObject.updateValues().formattedBillAmount)
            
        } else if firstResponderValue == 2 {
            
            amountValueWatchLabel.setText(varAmountsObject.updateValues().formattedTaxAmount)
            
        } else if firstResponderValue == 4 {
            
            amountValueWatchLabel.setText(varAmountsObject.updateValues().formattedTipRate)
            
        }
        
        MMObject.passMessageObject(["buttonsPressedAndFirstResponder":[arrayOfButtonsPressed, firstResponderValue]], identifier: "updateiPhoneView")
        
        
    }
    
    func updateColorValues() {
        
//        oneButtonOutlet.setAttributedTitle(NSAttributedString(string: "1", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
//        
//        twoButtonOutlet.setAttributedTitle(NSAttributedString(string: "2", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getSecondaryColorForWatch(), isFlat: true)]))
//        
//        threeButtonOutlet.setAttributedTitle(NSAttributedString(string: "3", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
//        
//        fourButtonOutlet.setAttributedTitle(NSAttributedString(string: "4", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getSecondaryColorForWatch(), isFlat: true)]))
//        
//        fiveButtonOutlet.setAttributedTitle(NSAttributedString(string: "5", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
//        
//        sixButtonOutlet.setAttributedTitle(NSAttributedString(string: "6", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getSecondaryColorForWatch(), isFlat: true)]))
//        
//        sevenButtonOutlet.setAttributedTitle(NSAttributedString(string: "7", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
//        
//        eightButtonOutlet.setAttributedTitle(NSAttributedString(string: "8", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getSecondaryColorForWatch(), isFlat: true)]))
//        
//        nineButtonOutlet.setAttributedTitle(NSAttributedString(string: "9", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
//        
//        zeroButtonOutlet.setAttributedTitle(NSAttributedString(string: "0", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColorForWatch(), isFlat: true)]))
//        
//        deleteButtonOutlet.setAttributedTitle(NSAttributedString(string: "⌫", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getSecondaryColorForWatch(), isFlat: true)]))
//        
//        doneButtonOutlet.setAttributedTitle(NSAttributedString(string: "⏎", attributes: [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getSecondaryColorForWatch(), isFlat: true)]))
        
        oneButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        twoButtonOutlet.setBackgroundColor(coloringThemes.getSecondaryColorForWatch())
        threeButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        fourButtonOutlet.setBackgroundColor(coloringThemes.getSecondaryColorForWatch())
        fiveButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        sixButtonOutlet.setBackgroundColor(coloringThemes.getSecondaryColorForWatch())
        sevenButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        eightButtonOutlet.setBackgroundColor(coloringThemes.getSecondaryColorForWatch())
        nineButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        zeroButtonOutlet.setBackgroundColor(coloringThemes.getMainColorForWatch())
        deleteButtonOutlet.setBackgroundColor(coloringThemes.getSecondaryColorForWatch())
        doneButtonOutlet.setBackgroundColor(coloringThemes.getSecondaryColorForWatch())
        
    }
    
}
