//
//  MyMercesPage.swift
//  Merces
//
//  Created by Donovan McCray on 3/19/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

class MyMercesPage: UITableViewController {
    
    let nmbrFormatter = NumberFormattingClass()
    
    var userLocalSalesTax = (NSUserDefaults(suiteName: "group.DoMar.merces")?.doubleForKey("userLocalSalesTax"))
    
    //Headlines
    @IBOutlet var collectionSettingsInformation: [UILabel]!
    
    @IBOutlet var collectionTableViewCells: [UITableViewCell]!
    
    
    @IBOutlet var presetBeingEditedLabel: UILabel!
    
    
    @IBOutlet var localSalesTaxOutlet: UITextField!
    @IBOutlet var venueSegmentedControlOutlet: UISegmentedControl!
    
    @IBOutlet var poorRatingTextFieldOutlet: UITextField!
    
    @IBOutlet var averageRatingTextFieldOutlet: UITextField!
    
    @IBOutlet var greatRatingTextFieldOutlet: UITextField!
    
    
    
    @IBAction func localSalesTax(sender: UITextField) {
        
        becomeFirstResponder()
        
    }
    
    @IBAction func poorRatingTextFieldTouchDown(sender: UITextField) {
        
        emptyArraysOfButtonsPressed()
        
        becomeFirstResponder()
        
    }
    
    @IBAction func averageRatingTextFieldTouchDown(sender: UITextField) {
        
        emptyArraysOfButtonsPressed()
        
        becomeFirstResponder()
        
    }
    
    @IBAction func greatRatingTextFieldTouchDown(sender: UITextField) {
        
        emptyArraysOfButtonsPressed()
        
        becomeFirstResponder()
        
    }
    
    var venueValueToEdit = "Quick"
    
    var arrayOfButtonsPressedForLocalSalesTax: [String] = []
    var arrayOfButtonsPressedForPoorTip: [String] = []
    var arrayOfButtonsPressedForAverageTip: [String] = []
    var arrayOfButtonsPressedForGreatTip: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateColorValues()
        
        localSalesTaxOutlet.inputView = NSBundle.mainBundle().loadNibNamed("KeypadView", owner: self, options: nil)[0] as? UIView
        
        poorRatingTextFieldOutlet.inputView = NSBundle.mainBundle().loadNibNamed("KeypadView", owner: self, options: nil)[0] as? UIView
        
        averageRatingTextFieldOutlet.inputView = NSBundle.mainBundle().loadNibNamed("KeypadView", owner: self, options: nil)[0] as? UIView
        
        greatRatingTextFieldOutlet.inputView = NSBundle.mainBundle().loadNibNamed("KeypadView", owner: self, options: nil)[0] as? UIView
        
        
        if userLocalSalesTax! == 0.0 {
            
            localSalesTaxOutlet.text = ""
            
            localSalesTaxOutlet.placeholder = "Local Sales Tax"
            
        } else {
            
            localSalesTaxOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(userLocalSalesTax!))"
            
        }
        
        if venueSegmentedControlOutlet.selectedSegmentIndex == -1 {
            
            venueSegmentedControlOutlet.selectedSegmentIndex = 2
            
        }
        
        editTipPresets()
        
        presetBeingEditedLabel.text = "Editing: \(venueValueToEdit.uppercaseString) Tip Presets"
        
        /*Dynamic Type Support */
        
        checkForDynamicType()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
        
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        
        checkForDynamicType()
        
    }
    
    func checkForDynamicType() {
        
//        if NSUserDefaults(suiteName: "group.DoMar.merces")?.boolForKey("useDynamicText") == true {
//            
//            for settingsHeadline in collectionSettingsInformation {
//                
//                settingsHeadline.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
//                
//            }
//            
//        } else {
//            
//            for settingsHeadline in collectionSettingsInformation {
//                
//                settingsHeadline.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
//                
//            }
//            
//        }
        
        for settingsHeadline in collectionSettingsInformation {
            
            settingsHeadline.font = NSUserDefaults(suiteName: "group.DoMar.merces")!.boolForKey("useDynamicText") ? UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline) : UIFont(name: "HelveticaNeue-Bold", size: 16)
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        updateColorValues()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func venueSegmentedControlValueChanged(sender: UISegmentedControl) {
        
        editTipPresets()
        
        emptyArraysOfButtonsPressed()
        
        presetBeingEditedLabel.text = "Editing: \(venueValueToEdit.uppercaseString) Tip Presets"
        
    }
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        var buttonTitle = sender.titleLabel!.text!
        
        if localSalesTaxOutlet.isFirstResponder() {
            
            arrayOfButtonsPressedForLocalSalesTax.append(buttonTitle)
            
            calculate(arrayOfButtonsPressedForLocalSalesTax, firstResponderValue: 5)
            
        } else if poorRatingTextFieldOutlet.isFirstResponder() {
            
            arrayOfButtonsPressedForPoorTip.append(buttonTitle)
            
            updateUserTipRates(arrayOfButtonsPressedForPoorTip, tipRateToEdit: 0)
            
        } else if averageRatingTextFieldOutlet.isFirstResponder() {
            
            arrayOfButtonsPressedForAverageTip.append(buttonTitle)
            
            updateUserTipRates(arrayOfButtonsPressedForAverageTip, tipRateToEdit: 1)
            
        } else if greatRatingTextFieldOutlet.isFirstResponder() {
            
            arrayOfButtonsPressedForGreatTip.append(buttonTitle)
            
            updateUserTipRates(arrayOfButtonsPressedForGreatTip, tipRateToEdit: 2)
            
        }
        
        
        updateFieldValues()
        
    }
    
    func calculate(arrayOfButtonsPressed: [String], firstResponderValue: Int) {
        
        varAmountsObject.calculate(arrayOfButtonsPressed, sentFirstResponderTag: firstResponderValue)
        
    }
    
    func updateUserTipRates(arrayOfButtonsPressed: [String], tipRateToEdit: Int) {
        
        
        varAmountsObject.userDefinedTipRatings(arrayOfButtonsPressed, venueToEdit: venueValueToEdit, tipRateToEdit: tipRateToEdit)
        
    }
    
    @IBAction func deletePressed(sender: UIButton) {
        
        if localSalesTaxOutlet.isFirstResponder() {
            
            if !arrayOfButtonsPressedForLocalSalesTax.isEmpty {
                
                arrayOfButtonsPressedForLocalSalesTax.removeLast()
                
            }
            
            calculate(arrayOfButtonsPressedForLocalSalesTax, firstResponderValue: 5)
            
        } else if poorRatingTextFieldOutlet.isFirstResponder() {
            
            if !arrayOfButtonsPressedForPoorTip.isEmpty {
                
                arrayOfButtonsPressedForPoorTip.removeLast()
                
            }
            
            updateUserTipRates(arrayOfButtonsPressedForPoorTip, tipRateToEdit: 0)
            
        } else if averageRatingTextFieldOutlet.isFirstResponder() {
            
            if !arrayOfButtonsPressedForAverageTip.isEmpty {
                
                arrayOfButtonsPressedForAverageTip.removeLast()
                
            }
            
            updateUserTipRates(arrayOfButtonsPressedForAverageTip, tipRateToEdit: 1)
            
        } else if greatRatingTextFieldOutlet.isFirstResponder() {
            
            if !arrayOfButtonsPressedForGreatTip.isEmpty {
                
                arrayOfButtonsPressedForGreatTip.removeLast()
                
            }
            
            updateUserTipRates(arrayOfButtonsPressedForGreatTip, tipRateToEdit: 2)
            
        }
        
        updateFieldValues()
        
    }
    
    @IBAction func donePressed(sender: UIButton) {
        
        if localSalesTaxOutlet.isFirstResponder() {
            
            localSalesTaxOutlet.resignFirstResponder()
            
        } else if poorRatingTextFieldOutlet.isFirstResponder() {
            
            poorRatingTextFieldOutlet.resignFirstResponder()
            
        } else if averageRatingTextFieldOutlet.isFirstResponder() {
            
            averageRatingTextFieldOutlet.resignFirstResponder()
            
        } else if greatRatingTextFieldOutlet.isFirstResponder() {
            
            greatRatingTextFieldOutlet.resignFirstResponder()
            
        }
        
        NSUserDefaults(suiteName: "group.DoMar.merces")?.setDouble(varAmountsObject.localSalesTax, forKey: "userLocalSalesTax")
        
        
        
    }
    
    
    
    override func becomeFirstResponder() -> Bool { return true }
    
    
    func updateFieldValues() {
        
        // Full Nav Bar Coloring
        self.navigationController?.navigationBar.barTintColor = coloringThemes.getMainColor()
        
        
        //Title Coloring
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn:coloringThemes.getMainColor(), isFlat: true)]
        
        
        // Back Button Coloring
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
        
        
        if varAmountsObject.localSalesTax == 0.00 {
            
            localSalesTaxOutlet.text = ""
            
            localSalesTaxOutlet.placeholder = "Local Sales Tax"
            
        } else {
            
            localSalesTaxOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.localSalesTax))"
            
        }
        
        (NSUserDefaults(suiteName: "group.DoMar.merces")?.setDouble(varAmountsObject.localSalesTax, forKey: "userLocalSalesTax"))
        
        editTipPresets()
        
    }
    
    func editTipPresets() {
        
        /*
        0 = Dining
        1 = Bar
        2 = Quick
        3 = Taxi
        4 = Salon
        5 = Casino
        6 = Delivery
        */
        
        
        
        switch venueSegmentedControlOutlet.selectedSegmentIndex {
            
        case 0:
            
            venueValueToEdit = "Dining"
            
            poorRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.diningTipArray[0]))"
            
            averageRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.diningTipArray[1]))"
            
            greatRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.diningTipArray[2]))"
            
            
        case 1:
            
            venueValueToEdit = "Bar"
            
            poorRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.barTipArray[0]))"
            
            averageRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.barTipArray[1]))"
            
            greatRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.barTipArray[2]))"
            
        case 2:
            
            venueValueToEdit = "Quick"
            
            poorRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.quickTipArray[0]))"
            
            averageRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.quickTipArray[1]))"
            
            greatRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.quickTipArray[2]))"
            
        case 3:
            
            venueValueToEdit = "Taxi"
            
            poorRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.taxiTipArray[0]))"
            
            averageRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.taxiTipArray[1]))"
            
            greatRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.taxiTipArray[2]))"
            
        case 4:
            
            venueValueToEdit = "Salon"
            
            poorRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.salonTipArray[0]))"
            
            averageRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.salonTipArray[1]))"
            
            greatRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.salonTipArray[2]))"
            
        case 5:
            
            venueValueToEdit = "Casino"
            
            poorRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.casinoTipArray[0]))"
            
            averageRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.casinoTipArray[1]))"
            
            greatRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.casinoTipArray[2]))"
            
        case 6:
            
            venueValueToEdit = "Delivery"
            
            poorRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.deliveryTipArray[0]))"
            
            averageRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.deliveryTipArray[1]))"
            
            greatRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithDecimalPlace(varAmountsObject.deliveryTipArray[2]))"
            
            
            
        default:
            
            venueValueToEdit = "None"
            
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        return 50
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header: UITableViewHeaderFooterView = view as UITableViewHeaderFooterView
        
        header.tintColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
        
        header.textLabel.textColor = coloringThemes.getBackgroundColor()
    }
    
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        let header: UITableViewHeaderFooterView = view as UITableViewHeaderFooterView
        
        header.tintColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
        
        header.textLabel.textColor = coloringThemes.getBackgroundColor()
        
    }
    
    
    func updateColorValues() {
        
        view.backgroundColor = coloringThemes.getBackgroundColor()
        
        for tableViewCell in collectionTableViewCells {
            
            tableViewCell.backgroundColor = coloringThemes.getBackgroundColor()
            
        }
        
        for settingsHeaders in collectionSettingsInformation {
            
            settingsHeaders.textColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
            
        }
        
        localSalesTaxOutlet.textColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
        
        localSalesTaxOutlet.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true).CGColor
        
        poorRatingTextFieldOutlet.textColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
        averageRatingTextFieldOutlet.textColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
        greatRatingTextFieldOutlet.textColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
        
        venueSegmentedControlOutlet.tintColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
        
    }
    
    func emptyArraysOfButtonsPressed() {
        
        arrayOfButtonsPressedForLocalSalesTax = []
        arrayOfButtonsPressedForPoorTip = []
        arrayOfButtonsPressedForAverageTip = []
        arrayOfButtonsPressedForGreatTip = []
        
    }
    
}
