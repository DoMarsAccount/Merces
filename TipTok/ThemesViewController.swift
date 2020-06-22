//
//  ThemesViewController.swift
//  TipTok
//
//  Created by Donovan McCray on 1/20/17.
//  Copyright © 2017 DoMarsToyBox. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /* ------ Collection Outlets ------ */
    
    @IBOutlet var collectionThemesCollectionViews: [UICollectionView]!
    @IBOutlet var collectionThemesLabels: [UILabel]!
    
    /* ------ Label Outlets ------ */
    
    @IBOutlet var themesLabel: UILabel!
    @IBOutlet var themesBackgroundLabel: UILabel!
    @IBOutlet var themesViewLabel: UILabel!
    
    /* ------ CollectionView Outlets ------ */
    
    @IBOutlet var themesCollectionView: UICollectionView!
    @IBOutlet var themesBackgroundCollectionView: UICollectionView!
    @IBOutlet var themesViewCollectionView: UICollectionView!
    
    let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for collectionView in collectionThemesCollectionViews {
            collectionView.layer.cornerRadius = 5
            collectionView.layer.borderWidth = 1
            collectionView.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
        }
        
        for themesLabel in collectionThemesLabels {
            themesLabel.layer.cornerRadius = 2
            themesLabel.layer.borderWidth = 4
            themesLabel.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
        }
            
        updateColorValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TipTokColor.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ThemesCollectionViewCell
        
        cell.layer.cornerRadius = cell.bounds.size.width / 2
        
        cell.layer.borderColor = themes.viewColor.cgColor
        
        cell.viewCellImageOutlet.layer.cornerRadius = cell.viewCellImageOutlet.bounds.size.width/2
        
//        cell.viewCellImageOutlet.backgroundColor = themes.arrayOfAllColors[indexPath.item]
        cell.viewCellImageOutlet.backgroundColor = Coloring().uiColorValue(for: TipTokColor.allCases[indexPath.item])
        
        cell.viewCellImageOutlet.layer.masksToBounds = true
        
        cell.viewCellImageOutlet.layer.borderWidth = 2
        
        cell.viewCellImageOutlet.layer.borderColor = UIColor.black.cgColor
        
        if collectionView == self.themesCollectionView {
            
            if Coloring().uiColorValue(for: TipTokColor.allCases[indexPath.item]) == themes.mainColor {
                cell.layer.borderWidth = 3
                cell.layer.borderColor = UIColor.green.cgColor
                themesLabel.text = "Main Color: \(TipTokColor.allCases[indexPath.item].name)"
            }
            
        } else if collectionView == self.themesBackgroundCollectionView {
            
            if Coloring().uiColorValue(for: TipTokColor.allCases[indexPath.item]) == themes.background {
                cell.layer.borderWidth = 3
                cell.layer.borderColor = UIColor.green.cgColor
                themesBackgroundLabel.text = "Background Color: \(TipTokColor.allCases[indexPath.item].name)"
            }
            
        } else if collectionView == self.themesViewCollectionView {
            
            if Coloring().uiColorValue(for: TipTokColor.allCases[indexPath.item]) == themes.viewColor {
                cell.layer.borderWidth = 3
                cell.layer.borderColor = UIColor.green.cgColor
                themesViewLabel.text = "View Color: \(TipTokColor.allCases[indexPath.item].name)"
            }
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        if collectionView == self.themesCollectionView {
            
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(TipTokColor.allCases[indexPath.item].stringRepresentation, forKey: "phoneMainColor")
            themesLabel.text = "Main Color: \(TipTokColor.allCases[indexPath.item].name)"
            
        } else if collectionView == self.themesBackgroundCollectionView {
            
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(TipTokColor.allCases[indexPath.item].stringRepresentation, forKey: "phoneBackgroundColor")
            themesBackgroundLabel.text = "Background Color: \(TipTokColor.allCases[indexPath.item].name)"
            
        } else if collectionView == self.themesViewCollectionView {
            
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(TipTokColor.allCases[indexPath.item].stringRepresentation, forKey: "phoneViewBackgroundColor")
            themesViewLabel.text = "View Color: \(TipTokColor.allCases[indexPath.item].name)"
            
        }
        collectionView.reloadData()
        self.updateColorValues()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }

    func updateColorValues() {
        
//        self.setStatusBarStyle(UIStatusBarStyleContrast)
        
        /* ------------ Navigation Bar Coloring ------------- */
        
        // Full Nav Bar Coloring
        self.navigationController?.navigationBar.barTintColor = themes.mainColor
        
        // Background Coloring
        self.view.backgroundColor = themes.background
        
        // Title Coloring
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: themes.mainColor, isFlat: true)!]
        
        
        // Back Button Coloring
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: themes.mainColor, isFlat: true)
        
        themesLabel.backgroundColor = themes.mainColor
        
        themesLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: themes.mainColor, isFlat: true)
        
        themesBackgroundLabel.backgroundColor = themes.background
        
        themesBackgroundLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: themes.background, isFlat: true)
        
        themesViewLabel.backgroundColor = themes.viewColor
        
        themesViewLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: themes.viewColor, isFlat: true)
        
        for collectionView in collectionThemesCollectionViews {
            
            collectionView.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
            
            collectionView.backgroundColor = themes.viewColor
            
        }
        
        for themesLabel in collectionThemesLabels {
            
            themesLabel.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
            
            themesLabel.font = UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 24)
            
        }
        
    }

}
