//
//  SettingsPage.swift
//  Merces
//
//  Created by Donovan McCray on 3/19/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit
import StoreKit

class SettingsPage: UITableViewController {

    @IBOutlet var totalAmountSwitch:UISwitch!
    @IBOutlet var tipAmountSwitch:UISwitch!
    @IBOutlet var tipIncludesTaxSwitch:UISwitch!
    @IBOutlet var useDynamicText: UISwitch!
    @IBOutlet var subtotalPostTaxSwitch: UISwitch!
    
    /* ------- Collection Outlets ------ */
    
    //Headlines
    @IBOutlet var collectionSettingsInformation: [UILabel]!
    
    @IBOutlet var collectionTableViewCell: [UITableViewCell]!
    
    @IBOutlet var collectionSwitches: [UISwitch]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userPrefs = UserPreferences.sharedInstance
        totalAmountSwitch.isOn = userPrefs.roundTotalAmount
        subtotalPostTaxSwitch.isOn = userPrefs.subtotalIsPostTax
        tipAmountSwitch.isOn = userPrefs.roundTipAmount
        tipIncludesTaxSwitch.isOn = userPrefs.tipIncludeTax
        useDynamicText.isOn = userPrefs.useDynamicText
        
        /* Dynamic Type Support */
        
        checkForDynamicType()
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(SettingsPage.preferredContentSizeChanged(_:)),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil)
        
        updateColorValues()
    }
    
    @objc func preferredContentSizeChanged(_ notification: Notification) {
        checkForDynamicType()
    }
    
    func checkForDynamicType() {
        for settingsHeadline in collectionSettingsInformation {
            settingsHeadline.font = UserPreferences.sharedInstance.useDynamicText ? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline) : UIFont(name: "HelveticaNeue-Bold", size: 16)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateColorValues()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let userPrefs = UserPreferences.sharedInstance
        userPrefs.roundTotalAmount = totalAmountSwitch.isOn
        userPrefs.roundTipAmount = tipAmountSwitch.isOn
        userPrefs.tipIncludeTax = tipIncludesTaxSwitch.isOn
        userPrefs.subtotalIsPostTax = subtotalPostTaxSwitch.isOn
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func totalAmountSwitchAction(_ sender: UISwitch) {
        UserPreferences.sharedInstance.roundTotalAmount = sender.isOn
    }
    
    @IBAction func tipAmountSwitchAction(_ sender: UISwitch) {
        UserPreferences.sharedInstance.roundTipAmount = sender.isOn
    }
    
    @IBAction func tipIncludesTaxSwitchAction(_ sender: UISwitch) {
        UserPreferences.sharedInstance.tipIncludeTax = sender.isOn
    }
    
    @IBAction func isSubtotalPostTaxSwitchAction(_ sender: UISwitch) {
        UserPreferences.sharedInstance.subtotalIsPostTax = sender.isOn
    }
    
    @IBAction func useDynamicTypeSwitchAction(_ sender: UISwitch) {
        UserPreferences.sharedInstance.useDynamicText = sender.isOn
        checkForDynamicType()
    }
    
    @IBAction func userWantsToRateButtonPressed(_ sender: AnyObject) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/merces-personal-tip-calculator/id978591776?ls=1&mt=8")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
    
    func updateColorValues() {
        
        /* ------------ Navigation Bar Coloring ------------- */
        self.navigationController?.navigationBar.barTintColor = coloringThemes.getMainColor()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)!]
        
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
        
        
        view.backgroundColor = coloringThemes.getBackgroundColor()
        
        
        for tableViewCell in collectionTableViewCell {
            tableViewCell.backgroundColor = coloringThemes.getViewBackgroundColor()
        }
        
        for settingsHeaders in collectionSettingsInformation {
            settingsHeaders.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
        }
        
        for switches in collectionSwitches {
            switches.onTintColor = coloringThemes.getMainColor()
            
            if coloringThemes.getMainColor() == coloringThemes.getViewBackgroundColor() {
                
                switches.onTintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
                
                switches.tintColor =  UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
        
        header.textLabel!.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        footer.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
        
        footer.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
