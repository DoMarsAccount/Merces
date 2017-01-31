//
//  ThemesViewController.swift
//  Merces
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
        return coloringThemes.arrayOfAllColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ThemesCollectionViewCell
        
        cell.layer.cornerRadius = cell.bounds.size.width / 2
        
        cell.layer.borderColor = coloringThemes.getViewBackgroundColor().cgColor
        
        cell.viewCellImageOutlet.layer.cornerRadius = cell.viewCellImageOutlet.bounds.size.width/2
        
        cell.viewCellImageOutlet.backgroundColor = coloringThemes.arrayOfAllColors[indexPath.item]
        
        cell.viewCellImageOutlet.layer.masksToBounds = true
        
        cell.viewCellImageOutlet.layer.borderWidth = 2
        
        cell.viewCellImageOutlet.layer.borderColor = UIColor.black.cgColor
        
        if collectionView == self.themesCollectionView {
            
            if coloringThemes.arrayOfAllColors[indexPath.item] == coloringThemes.getMainColor() {
                
                cell.layer.borderWidth = 3
                
                cell.layer.borderColor = UIColor.green.cgColor
                
                themesLabel.text = "Main Color: \(coloringThemes.arrayOfAllColorNames[indexPath.item])"
                
            }
            
        } else if collectionView == self.themesBackgroundCollectionView {
            
            if coloringThemes.arrayOfAllColors[indexPath.item] == coloringThemes.getBackgroundColor() {
                
                cell.layer.borderWidth = 3
                
                cell.layer.borderColor = UIColor.green.cgColor
                
                themesBackgroundLabel.text = "Background Color: \(coloringThemes.arrayOfAllColorNames[indexPath.item])"
                
            }
            
        } else if collectionView == self.themesViewCollectionView {
            
            if coloringThemes.arrayOfAllColors[indexPath.item] == coloringThemes.getViewBackgroundColor() {
                
                cell.layer.borderWidth = 3
                
                cell.layer.borderColor = UIColor.green.cgColor
                
                themesViewLabel.text = "View Color: \(coloringThemes.arrayOfAllColorNames[indexPath.item])"
                
            }
            
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        if collectionView == self.themesCollectionView {
        
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set("\(coloringThemes.arrayOfAllColors[indexPath.row])", forKey: "phoneMainColor")
            
            themesLabel.text = "Main Color: \(coloringThemes.arrayOfAllColorNames[indexPath.item])"
            
        } else if collectionView == self.themesBackgroundCollectionView {
            
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set("\(coloringThemes.arrayOfAllColors[indexPath.row])", forKey: "phoneBackgroundColor")
            
            themesBackgroundLabel.text = "Background Color: \(coloringThemes.arrayOfAllColorNames[indexPath.item])"
            
        } else if collectionView == self.themesViewCollectionView {
            
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set("\(coloringThemes.arrayOfAllColors[indexPath.row])", forKey: "phoneViewBackgroundColor")
            
            themesViewLabel.text = "View Color: \(coloringThemes.arrayOfAllColorNames[indexPath.item])"
            
        }
        
        collectionView.reloadData()
        
        self.updateColorValues()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        collectionView.reloadData()
        
    }
    
    

    func updateColorValues() {
        
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        
        /* ------------ Navigation Bar Coloring ------------- */
        
        // Full Nav Bar Coloring
        self.navigationController?.navigationBar.barTintColor = coloringThemes.getMainColor()
        
        // Background Coloring
        self.view.backgroundColor = coloringThemes.getBackgroundColor()
        
        // Title Coloring
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)]
        
        
        // Back Button Coloring
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
        
        themesLabel.backgroundColor = coloringThemes.getMainColor()
        
        themesLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
        
        themesBackgroundLabel.backgroundColor = coloringThemes.getBackgroundColor()
        
        themesBackgroundLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
        
        themesViewLabel.backgroundColor = coloringThemes.getViewBackgroundColor()
        
        themesViewLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
        
        for collectionView in collectionThemesCollectionViews {
            
            collectionView.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
            
            collectionView.backgroundColor = coloringThemes.getViewBackgroundColor()
            
        }
        
        for themesLabel in collectionThemesLabels {
            
            themesLabel.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
            
        }
        
        
    }

}
