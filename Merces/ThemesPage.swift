//
//  ThemesPage.swift
//  Merces
//
//  Created by Donovan McCray on 3/19/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit
import ChameleonFramework

class ThemesPage: UITableViewController {
    
    var haveShownColorAlert =  UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "changeColorAlertShown")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.rowHeight = UITableView.automaticDimension
        
        updateColorValues()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        updateColorValues()
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coloringThemes.arrayOfAllColors.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "themesTableCell", for: indexPath) as UITableViewCell
        
        cell.backgroundColor = coloringThemes.arrayOfAllColors[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 24)
        
        cell.textLabel?.text = coloringThemes.arrayOfAllColorNames[indexPath.row]
        
        cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.arrayOfAllColors[indexPath.row], isFlat: true)
        
        if UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "useDynamicText") == true {
            
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
            
        } else {
            
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 24)
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if haveShownColorAlert == false {
        
            let alert = UIAlertController(title: NSLocalizedString("Whoops", comment: "Whoops"), message: NSLocalizedString("Don't tap. Swipe!", comment: "Don't tap the glass/ screen. Instead, swipe to the left."), preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Ok"), style: UIAlertAction.Style.default, handler: { (_) in
                
                UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(true, forKey: "changeColorAlertShown")
                
                self.haveShownColorAlert = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "changeColorAlertShown")
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let setMainColorAction = UITableViewRowAction(style: .normal, title: NSLocalizedString("MainColor", comment: "Main Color"), handler: { _,_   in
            
            self.tableView.setEditing(false, animated: true)
            
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set("\(coloringThemes.arrayOfAllColors[indexPath.row])", forKey: "phoneMainColor")
            
            self.updateColorValues()
            
        })
        
        let setBackgroundColorAction = UITableViewRowAction(style: .default, title: NSLocalizedString("SecondaryColor", comment: "Secondary Color"), handler: { _,_   in
            
            self.tableView.setEditing(false, animated: true)
            
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set("\(coloringThemes.arrayOfAllColors[indexPath.row])", forKey: "phoneBackgroundColor")
            
            self.updateColorValues()
            
        })
        
        UIButton.appearance().setTitleColor(UIColor.black, for: UIControl.State())
        
        setMainColorAction.backgroundColor = coloringThemes.getMainColor()
        
        
        setBackgroundColorAction.backgroundColor = coloringThemes.getBackgroundColor()
        
        
        
        return [setMainColorAction, setBackgroundColorAction]
        
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 75.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 75.0
    }
    
    func updateColorValues() {
        
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        
        /* ------------ Navigation Bar Coloring ------------- */
        
        // Full Nav Bar Coloring
        self.navigationController?.navigationBar.barTintColor = coloringThemes.getMainColor()
        
        // Background Coloring
        self.view.backgroundColor = coloringThemes.getBackgroundColor()
        
        // Title Coloring
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)]
        
        
        // Back Button Coloring
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
        
        
        self.tableView.setEditing(false, animated: true)
        
        
    }

}
