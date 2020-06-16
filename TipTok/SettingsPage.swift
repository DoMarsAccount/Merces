//
//  SettingsPage.swift
//  TipTok
//
//  Created by Donovan McCray on 3/19/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit
import StoreKit
import Combine

class SettingsPage: UITableViewController {
    
    @Published var roundTotal = UserPreferences.sharedInstance.$roundTotalAmount

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
    
    private var roundTotalAmountSubscriber: AnyCancellable?
    private var roundTipAmountSubscriber: AnyCancellable?
    private var subtotalPostTaxSubscriber: AnyCancellable?
    private var tipIncludesTaxSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userPrefs = UserPreferences.sharedInstance
        
        totalAmountSwitch.isOn = userPrefs.roundTotalAmount
        tipAmountSwitch.isOn = userPrefs.roundTipAmount
        subtotalPostTaxSwitch.isOn = userPrefs.subtotalIsPostTax
        tipIncludesTaxSwitch.isOn = userPrefs.tipIncludeTax
        useDynamicText.isOn = userPrefs.useDynamicText
        
        roundTotalAmountSubscriber = userPrefs.$roundTotalAmount.assign(to: \.isOn, on: totalAmountSwitch)
        roundTipAmountSubscriber = userPrefs.$roundTipAmount.assign(to: \.isOn, on: tipAmountSwitch)
        subtotalPostTaxSubscriber = userPrefs.$subtotalIsPostTax.assign(to: \.isOn, on: subtotalPostTaxSwitch)
        tipIncludesTaxSubscriber = userPrefs.$tipIncludeTax.assign(to: \.isOn, on: tipIncludesTaxSwitch)
        
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
            settingsHeadline.font = UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 16)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateColorValues()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
//        roundTotalAmountSubscriber?.cancel()
//        roundTipAmountSubscriber?.cancel()
//        subtotalPostTaxSubscriber?.cancel()
//        tipIncludesTaxSubscriber?.cancel()
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
        SKStoreReviewController.requestReview()
    }
    
    func updateColorValues() {
        
        /* ------------ Navigation Bar Coloring ------------- */
        self.navigationController?.navigationBar.barTintColor = coloringThemes.mainColor
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.mainColor, isFlat: true)!]
        
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.mainColor, isFlat: true)
        
        
        view.backgroundColor = coloringThemes.backgroundColor
        
        
        for tableViewCell in collectionTableViewCell {
            tableViewCell.backgroundColor = coloringThemes.viewBackgroundColor
        }
        
        for settingsHeaders in collectionSettingsInformation {
            settingsHeaders.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.viewBackgroundColor, isFlat: true)
        }
        
        for switches in collectionSwitches {
            switches.onTintColor = coloringThemes.mainColor
            
            if coloringThemes.mainColor == coloringThemes.viewBackgroundColor {
                
                switches.onTintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.mainColor, isFlat: true)
                
                switches.tintColor =  UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.mainColor, isFlat: true)
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.backgroundColor, isFlat: true)
        
        header.textLabel!.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.backgroundColor, isFlat: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        footer.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.backgroundColor, isFlat: true)
        
        footer.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.backgroundColor, isFlat: true)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
