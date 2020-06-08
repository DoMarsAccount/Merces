//
//  MyMerces.swift
//  Merces
//
//  Created by Donovan McCray on 3/21/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit
import ChameleonFramework

class MyMerces: UIViewController {
    
    var userWantsToEditThisField: String!
    
    var keypadIsUp = false
    
    @IBOutlet var keypadStuffView: UIView!

    let nmbrFormatter = NumberFormattingClass()
    
    
    /* ----------------- Collection Outlets --------------------- */
    
    @IBOutlet var collectionInputFieldLabels: [UITextField]!
    
    @IBOutlet var collectionHeaderLabels: [UILabel]!
    
    @IBOutlet var collectionKeypadButtons: [UIButton]!
    
    @IBOutlet var collectionMainViews: [UIView]!
    
    
    /* ----------------- Views -------------------- */
    
    @IBOutlet var keypadView: UIView!
    
    /* ----------------- Outlets -------------------- */
    
    @IBOutlet var localSalesTaxOutlet: UITextField!
    
    @IBOutlet var venueSegmentedControlOutlet: UISegmentedControl!
    
    @IBOutlet var venueServiceQualityLabelOutlet: UILabel!
    
    
    @IBOutlet var poorRatingTextFieldOutlet: UITextField!
    
    @IBOutlet var averageRatingTextFieldOutlet: UITextField!
    
    @IBOutlet var greatRatingTextFieldOutlet: UITextField!
    
    var venueValueToEdit: VenueType = .quick
    var translatedVenueValueToEdit = "Quick"
    
    var arrayOfButtonsPressedForLocalSalesTax: [String] = []
    var arrayOfButtonsPressedForPoorTip: [String] = []
    var arrayOfButtonsPressedForAverageTip: [String] = []
    var arrayOfButtonsPressedForGreatTip: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        
        updateColorValues()
        
        updateFieldValues()
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(MyMerces.preferredContentSizeChanged(_:)),
            name: NSNotification.Name.UIContentSizeCategoryDidChange,
            object: nil)
        
        mUserDefaults?.set(userPrefs.localSalesTax, forKey: "userLocalSalesTax")
        
    }
    
    @objc func preferredContentSizeChanged(_ notification: Notification) {
        updateFieldValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateColorValues()
    }
    
    
    /* =================== User Input Actions ====================== */
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        springForKeypadButtonsPressed(sender: sender, animations: {
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            let buttonTitle = sender.titleLabel!.text!
            
            if self.userWantsToEditThisField == "Local Sales Tax Rate" {
                
                self.arrayOfButtonsPressedForLocalSalesTax.append(buttonTitle)
                
                self.calculate(self.arrayOfButtonsPressedForLocalSalesTax, firstResponderValue: 5)
                
            } else if self.userWantsToEditThisField == "Poor Service Rating" {
                
                self.arrayOfButtonsPressedForPoorTip.append(buttonTitle)
                
                self.updateUserTipRates(self.arrayOfButtonsPressedForPoorTip, tipRateToEdit: 0)
                
            } else if self.userWantsToEditThisField == "Average Service Rating" {
                
                self.arrayOfButtonsPressedForAverageTip.append(buttonTitle)
                
                self.updateUserTipRates(self.arrayOfButtonsPressedForAverageTip, tipRateToEdit: 1)
                
            } else if self.userWantsToEditThisField == "Outstanding Service Rating" {
                
                self.arrayOfButtonsPressedForGreatTip.append(buttonTitle)
                
                self.updateUserTipRates(self.arrayOfButtonsPressedForGreatTip, tipRateToEdit: 2)
                
            }
            
            self.updateFieldValues()

            
        })
        
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        
        springForKeypadButtonsPressed(sender: sender, animations: {
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            if self.userWantsToEditThisField == "Local Sales Tax Rate" {
                
                if !self.arrayOfButtonsPressedForLocalSalesTax.isEmpty {
                    
                    self.arrayOfButtonsPressedForLocalSalesTax.removeLast()
                    
                }
                
                self.calculate(self.arrayOfButtonsPressedForLocalSalesTax, firstResponderValue: 5)
                
            } else if self.userWantsToEditThisField == "Poor Service Rating" {
                
                if !self.arrayOfButtonsPressedForPoorTip.isEmpty {
                    
                    self.arrayOfButtonsPressedForPoorTip.removeLast()
                    
                }
                
                self.updateUserTipRates(self.arrayOfButtonsPressedForPoorTip, tipRateToEdit: 0)
                
            } else if self.userWantsToEditThisField == "Average Service Rating" {
                
                if !self.arrayOfButtonsPressedForAverageTip.isEmpty {
                    
                    self.arrayOfButtonsPressedForAverageTip.removeLast()
                    
                }
                
                self.updateUserTipRates(self.arrayOfButtonsPressedForAverageTip, tipRateToEdit: 1)
                
            } else if self.userWantsToEditThisField == "Outstanding Service Rating" {
                
                if !self.arrayOfButtonsPressedForGreatTip.isEmpty {
                    
                    self.arrayOfButtonsPressedForGreatTip.removeLast()
                    
                }
                
                self.updateUserTipRates(self.arrayOfButtonsPressedForGreatTip, tipRateToEdit: 2)
                
            }
            
            self.updateFieldValues()
            
        })
        
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } else {
            // Fallback on earlier versions
        }
        
        unshrinkViews()
        
        if userWantsToEditThisField == "Local Sales Tax Rate" {
            
            keypadDisappear()
            
        } else if userWantsToEditThisField == "Poor Service Rating" {
            
            keypadDisappear()
            
        } else if userWantsToEditThisField == "Average Service Rating" {
            
            keypadDisappear()
            
        } else if userWantsToEditThisField == "Outstanding Service Rating" {
            
            keypadDisappear()
            
        }
        
        mUserDefaults?.set(userPrefs.localSalesTax, forKey: "userLocalSalesTax")
        
    }
    
    @IBAction func venueSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        editTipPresets()
        
        emptyArraysOfButtonsPressed()
        
    }
    
    
    /*  ======================   Button Masks  ====================== */

    @IBAction func localSalesTaxRateMaskButton(_ sender: AnyObject) {
        
        keypadAppear()
        
        userWantsToEditThisField = "Local Sales Tax Rate"
        
        shrinkViewsNotBeingEdited(localSalesTaxOutlet.tag)
        
    }
    
    @IBAction func poorServiceRatingMaskButton(_ sender: AnyObject) {
        
        keypadAppear()
        
        emptyArraysOfButtonsPressed()
        
        userWantsToEditThisField = "Poor Service Rating"
        
        shrinkViewsNotBeingEdited(poorRatingTextFieldOutlet.tag)
        
    }
    
    @IBAction func averageServiceRatingMaskButton(_ sender: AnyObject) {
        
        keypadAppear()
        
        emptyArraysOfButtonsPressed()
        
        userWantsToEditThisField = "Average Service Rating"
        
        shrinkViewsNotBeingEdited(averageRatingTextFieldOutlet.tag)
        
    }
    
    @IBAction func outstandingServiceRatingMaskButton(_ sender: AnyObject) {
        
        keypadAppear()
        
        emptyArraysOfButtonsPressed()
        
        userWantsToEditThisField = "Outstanding Service Rating"
        
        shrinkViewsNotBeingEdited(greatRatingTextFieldOutlet.tag)
        
    }
    
    
    
    /* ------------------ Updating Values and Views -------------------- */
    
    func calculate(_ arrayOfButtonsPressed: [String], firstResponderValue: Int) {
        var activeField: EditableTextFields = .none
        
        switch firstResponderValue {
        case 1:
            activeField = .subtotal
        case 2:
            activeField = .salesTax
        case 3:
            activeField = .numPeople
        case 4:
            activeField = .tipRate
        case 5:
            activeField = .venue
        default:
            activeField = .none
        }
        
        varAmountsObject.processInput(arrayOfButtonsPressed, activeField: activeField)
        
    }
    
    func updateUserTipRates(_ arrayOfButtonsPressed: [String], tipRateToEdit: Int) {
        userDefinedTipRatings(arrayOfButtonsPressed, venueToEdit: venueValueToEdit, tipRateToEdit: tipRateToEdit)
    }
    
    func updateFieldValues() {
        
        for headerLabels in collectionHeaderLabels {
            headerLabels.font = userPrefs.checkForDynamicType(preferredFontSize: 20)
        }
        
        for inputFields in collectionInputFieldLabels {
            inputFields.font = userPrefs.checkForDynamicType(preferredFontSize: 24)
        }
        
        for keypadButtons in collectionKeypadButtons {
            keypadButtons.titleLabel?.font = userPrefs.checkForDynamicType(preferredFontSize: 28)
        }
        
        if venueSegmentedControlOutlet.selectedSegmentIndex == -1 {
            venueSegmentedControlOutlet.selectedSegmentIndex = 2
        }
        
        if userPrefs.localSalesTax == 0.00 {
            localSalesTaxOutlet.text = "0.000%"
        } else {
            localSalesTaxOutlet.text = "\(nmbrFormatter.roundForPercentWithThreeDecimalPlaces(number: userPrefs.localSalesTax))"
        }
        
        mUserDefaults?.set(userPrefs.localSalesTax, forKey: "userLocalSalesTax")
        
        editTipPresets()
        
    }
    
    func updateColorValues() {
        
        /* ------------ Navigation Bar Coloring ------------- */
        self.navigationController?.navigationBar.barTintColor = coloringThemes.getMainColor()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true) ]
        
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
        
        view.backgroundColor = coloringThemes.getBackgroundColor()
        
        
        // for billTax, Venue, and totaledAmounts Views
        for MainViews in collectionMainViews {
            
            MainViews.layer.cornerRadius = 5
            
            MainViews.layer.borderWidth = 1
            
            MainViews.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
            
            MainViews.backgroundColor = coloringThemes.getViewBackgroundColor()
            
        }
        
        
        /* -------- KeypadView coloring ---------- */
        
        keypadStuffView.layer.cornerRadius = 5
        
        keypadStuffView.layer.borderWidth = 2.5
        
        keypadStuffView.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
        
        keypadStuffView.backgroundColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
        
        
        for keypadButtons in collectionKeypadButtons {
            
            keypadButtons.setTitleColor(UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true), for: .normal)
            
            keypadButtons.setTitleColor(UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true), for: .highlighted)
            
            keypadButtons.setTitleColor(UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true), for: .selected)
            
            keypadButtons.layer.borderWidth = 1.5
            
            keypadButtons.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true).cgColor
            
            keypadButtons.backgroundColor = coloringThemes.getMainColor()
            
            keypadButtons.layer.cornerRadius = 5
            
        }
        
        
        for headerLabels in collectionHeaderLabels {
            
            headerLabels.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
            //UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
            
        }
        
        
        for inputFields in collectionInputFieldLabels {
            
            inputFields.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
            //UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
            
            inputFields.layer.cornerRadius = 2.5
            
            inputFields.layer.borderWidth = 1
            
            inputFields.layer.borderColor = inputFields.textColor!.cgColor
            
        }
        
        venueSegmentedControlOutlet.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
        //UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
        
    }
    
    
    /* ====================== ANIMATIONS ===================== */
    
    /* ------------------------ Input Fields Appear & Dissapear ------------------ */
    
    func keypadAppear() {
        
       if keypadIsUp != true {
            
            keypadStuffView.isHidden = false; keypadStuffView.alpha = 0.0
            
            keypadStuffView.transform = CGAffineTransform(translationX: 0, y: 200)
            
            
            spring(0.9, animations: {
            
                
                self.keypadStuffView.alpha = 1.0
                
                self.keypadStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            })
            
        }
        
        keypadIsUp = true
        
    }
    
    func keypadDisappear() {
        
        keypadIsUp = false
        
        keypadStuffView.alpha = 1.0
        
        
        spring(0.7, animations: {
            
            self.keypadStuffView.alpha = 0.0
            
            self.keypadStuffView.transform = CGAffineTransform(translationX: 0, y: 200)
            
        })
        
    }
    
    /* ------------------------ View Shrinking & Unshrinking --------------------- */
    
    func shrinkViewsNotBeingEdited(_ editedViewsTag: Int) {
        
        for textFields in collectionInputFieldLabels {
            
            spring(0.7, animations: {
                
                if editedViewsTag != textFields.tag {
                    
                    textFields.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    
                    textFields.layer.borderWidth = 1.0
                    
                } else {
                    
                    textFields.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    
                    textFields.layer.borderWidth = 0.0
                    
                }
                
            })
            
        }
        
        for headerLabels in collectionHeaderLabels {
            
            spring(0.7, animations: {
                
                if headerLabels.tag != 0 {
                    
                    if editedViewsTag != headerLabels.tag {
                        
                        headerLabels.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        
                    } else {
                        
                        headerLabels.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        
                    }
                }
                
            })
            
        }
        
    }
    
    func unshrinkViews() {
        
        for textFields in collectionInputFieldLabels {
            
            spring(0.7, animations: {
                
                textFields.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
                textFields.layer.borderWidth = 1.0
                
            })
            
        }
        
        for headerLabels in collectionHeaderLabels {
            
            spring(0.7, animations: {
                    
                headerLabels.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
            })
            
        }
        
    }
    
    func editTipPresets() {
        
        /*
        0 = Dining
        1 = Bar
        2 = Quick
        3 = Taxi
        4 = Salon
        5 = Delivery
        */
        
        switch venueSegmentedControlOutlet.selectedSegmentIndex {
            
        case 0:
            venueValueToEdit = .dining
            translatedVenueValueToEdit = NSLocalizedString("Dining", comment: "Dining")
            
        case 1:
            venueValueToEdit = .bar
            translatedVenueValueToEdit = NSLocalizedString("Bar", comment: "Bar")
            
        case 2:
            venueValueToEdit = .quick
            translatedVenueValueToEdit = "Quick"
            
        case 3:
            venueValueToEdit = .taxi
            translatedVenueValueToEdit = NSLocalizedString("Taxi", comment: "Taxi")
            
        case 4:
            venueValueToEdit = .salon
            translatedVenueValueToEdit = NSLocalizedString("Salon", comment: "Salon")
            
        case 5:
            venueValueToEdit = .delivery
            translatedVenueValueToEdit = NSLocalizedString("Delivery", comment: "Delivery")
            
        default:
            venueValueToEdit = .none
            
        }
        
        poorRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithTwoDecimalPlaces(tipRates(for: venueValueToEdit)[0]))"
        
        averageRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithTwoDecimalPlaces(tipRates(for: venueValueToEdit)[1]))"
        
        greatRatingTextFieldOutlet.text = "\(nmbrFormatter.roundForPercentWithTwoDecimalPlaces(tipRates(for: venueValueToEdit)[2]))"
        
        
        
        //venueServiceQualityLabelOutlet.text = translatedVenueValueToEdit + " " + NSLocalizedString("Venue Service Quality", comment:"Venue Service Quality Settings")
        
        venueServiceQualityLabelOutlet.text = "Venue: " + translatedVenueValueToEdit
        
        
    }
    
    
    func emptyArraysOfButtonsPressed() {
        arrayOfButtonsPressedForLocalSalesTax = []
        arrayOfButtonsPressedForPoorTip = []
        arrayOfButtonsPressedForAverageTip = []
        arrayOfButtonsPressedForGreatTip = []
    }

}
