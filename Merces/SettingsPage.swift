//
//  SettingsPage.swift
//  Merces
//
//  Created by Donovan McCray on 3/19/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

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
        
        let roundTotalAmountOnOff = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "roundTotalAmountSwitchOnOff")
        
        totalAmountSwitch.isOn = roundTotalAmountOnOff!
        
        let subtotalIsPostTaxSwitchOnOff = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "subtotalIsPostTaxSwitchOnOff")
        
        subtotalPostTaxSwitch.isOn = subtotalIsPostTaxSwitchOnOff!
        
        let roundTipAmountOnOff = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "roundTipAmountSwitchOnOff")
        
        tipAmountSwitch.isOn = roundTipAmountOnOff!
        
        let tipIncludesTaxOnOff = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "tipIncludeTaxSwitchOnOff")
        
        tipIncludesTaxSwitch.isOn = tipIncludesTaxOnOff!
        
        
        let userWantsDynamicText = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "useDynamicText")
        
        useDynamicText.isOn = userWantsDynamicText!
        
        
        /* Dynamic Type Support */
        
        checkForDynamicType()
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(SettingsPage.preferredContentSizeChanged(_:)),
            name: NSNotification.Name.UIContentSizeCategoryDidChange,
            object: nil)
        
        
        updateColorValues()
    }
    
    func preferredContentSizeChanged(_ notification: Notification) {
        
        checkForDynamicType()
        
    }
    
    func checkForDynamicType() {
        
        
        for settingsHeadline in collectionSettingsInformation {
            
            settingsHeadline.font = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")!.bool(forKey: "useDynamicText") ? UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline) : UIFont(name: "HelveticaNeue-Bold", size: 16)
            
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        updateColorValues()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(totalAmountSwitch.isOn, forKey: "roundTotalAmountSwitchOnOff")
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(tipAmountSwitch.isOn, forKey: "roundTipAmountSwitchOnOff")
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(tipIncludesTaxSwitch.isOn, forKey: "tipIncludeTaxSwitchOnOff")
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(subtotalPostTaxSwitch.isOn, forKey: "subtotalIsPostTaxSwitchOnOff")
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 50
    }
    
    
    
    @IBAction func totalAmountSwitchAction(_ sender: UISwitch) {
        
        //MMObject.passMessageObject(["totalAmountSwitchChanged":self.totalAmountSwitch.on], identifier: "updateiWatchSettings")
        
    }
    
    @IBAction func tipAmountSwitchAction(_ sender: UISwitch) {
        
        //MMObject.passMessageObject(["tipAmountSwitchChanged": self.tipAmountSwitch.on], identifier: "updateiWatchSettings")
        
    }
    
    @IBAction func tipIncludesTaxSwitchAction(_ sender: UISwitch) {
        
        //MMObject.passMessageObject(["tipIncludesTaxSwitchChanged": self.tipIncludesTaxSwitch.on], identifier: "updateiWatchSettings")
        
    }
    
    @IBAction func useDynamicTypeSwitchAction(_ sender: UISwitch) {
        
        UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(sender.isOn, forKey: "useDynamicText")
        
        checkForDynamicType()
        
    }
    
    
    @IBAction func userWantsToRateButtonPressed(_ sender: AnyObject) {
        
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/merces-personal-tip-calculator/id978591776?ls=1&mt=8")!, options: [:], completionHandler: nil)
        
        print("Test")

    }
    
    
    func updateColorValues() {
        
        /* ------------ Navigation Bar Coloring ------------- */
        self.navigationController?.navigationBar.barTintColor = coloringThemes.getMainColor()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)]
        
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
            
            switches.tintColor =  coloringThemes.getMainColor()
            
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
