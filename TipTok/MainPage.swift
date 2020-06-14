
//
//  MainPage.swift
//  TipTok
//
//  Created by Donovan McCray on 3/19/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit
import ChameleonFramework

let coloringThemes = ColoringAndThemes()

@available(iOS 10.0, *)
class MainPage: UIViewController {
    
    var userEditingThisField: EditableTextFields = .none
    var userWantsToEditThisField: String!
    
    var keypadIsUp = false
    var venueSelectorIsUp = false
    var totalAmountsViewIsFull = false
    
    /* ----------------- Collection Outlets --------------------- */
    
    @IBOutlet var collectionSectionHeaderLabels: [UILabel]!
    
    @IBOutlet var collectionTotaledAmountsLabels: [UILabel]!
    
    @IBOutlet var collectionInputFieldLabels: [UITextField]!
    
    @IBOutlet var collectionTotaledAmountDisplays: [UILabel]!
    
    @IBOutlet var collectionKeypadButtons: [UIButton]!
    
    @IBOutlet var collectionVenueViews: [UIView]!
    
    @IBOutlet var collectionVenueLabels: [UILabel]!
    
    @IBOutlet var collectionMainViews: [UIView]!
    
    /* ----------------- Views -------------------- */
    
    @IBOutlet var billTaxPeopleStuffView: UIView!
    
    @IBOutlet var venueAndServiceStuffView: UIView!
    
    @IBOutlet var totaledAmountsStuffView: UIView!
    
    @IBOutlet var keypadStuffView: UIView!
    
    @IBOutlet var venuesStuffView: UIView!
    
    /* ----------------- Outlets -------------------- */
    
    @IBOutlet var billAmountTextFieldOutlet: UITextField!
    @IBOutlet var taxAmountTextFieldOutlet: UITextField!
    @IBOutlet var tipRateTextFieldOutlet: UITextField!
    @IBOutlet var numberOfPeoplePayingTextFieldOutlet: UITextField!
    @IBOutlet var venueSelectionLabelOutlet: UITextField!
    
    @IBOutlet var serviceRatingLabelOutlet: UISegmentedControl!
    
    @IBOutlet var settingsIconOutlet: UIBarButtonItem!
    @IBOutlet var modeSwitchOutlet: UIBarButtonItem!

    @IBOutlet var totaledAmountsLabel: UILabel!
    
    @IBOutlet var tipAmountLabelOutlet: UILabel!
    @IBOutlet var totalAmountPerPersonLabelOutlet: UILabel!
    @IBOutlet var totalAmountLabelOutlet: UILabel!
    
    @IBOutlet var tipAmountTitleLabel: UILabel!
    @IBOutlet var totalAmountPerPersonTitleLabel: UILabel!
    @IBOutlet var totalAmountTitleLabel: UILabel!
    
    @IBOutlet weak var taxAmountMaskOutlet: UIButton!
    
    @IBOutlet var coinsImageOutlet: UIImageView!
    
    @IBOutlet var moreOrLessPerPersonLabel: UILabel!
    
    /* ----------------- Constraint Outlets -------------------- */
    
    @IBOutlet var singlePersonTotaledAmountsViewCOnstraint: NSLayoutConstraint!
    
    
    @IBOutlet var noTipSplitPersonViewConstraint: NSLayoutConstraint!
    
    @IBOutlet var noTipSplitPersonViewConstraint2: NSLayoutConstraint!
    
    
    @IBOutlet var tipAmountsLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet var tipAmountsDisplayConstraint: NSLayoutConstraint!
    

    @IBOutlet var gTotalDisplayConstraint: NSLayoutConstraint!
    
    @IBOutlet var gTotalLabelConstraint: NSLayoutConstraint!
    
    
    /* ---- Default Field Sizes ----- */
    
    var origTipAmountTitleLabelHeight:CGFloat = 0.0
    
    var origTipAmountTitleLabelY:CGFloat = 0.0
    
    var origTipAmountLabelHeight:CGFloat = 0.0
    
    var origTipAmountLabelY:CGFloat = 0.0
    
    var origTotalAmountPerPersonTitleLabelHeight:CGFloat = 0.0
    
    var origTotalAmountPerPersonTitleLabelY:CGFloat = 0.0
    
    var origTotalAmountPerPersonalLabelHeight:CGFloat = 0.0
    
    var origTotalAmountPerPersonalLabelY:CGFloat = 0.0
    
    var origTotalAmountTitleLabelHeight:CGFloat = 0.0
    
    var origTotalAmountTitleLabelY:CGFloat = 0.0
    
    var origTotalAmountLabelHeight:CGFloat = 0.0
    
    var origTotalAmountLabelY:CGFloat = 0.0
    
    var origTotaledAmountsFrameHeight:CGFloat = 0.0
    
    var origTotaledAmountsFrameWidth:CGFloat = 0.0
    
    var origTotaledAmountsFrameY:CGFloat = 0.0
    
    var origTotaledAmountsLabelHeight:CGFloat = 0.0
    
    var origTotaledAmountsLabelWidth:CGFloat = 0.0
    
    var origTotaledAmountsLabelY:CGFloat = 0.0
    
    /* --------------- Else -------------- */
    
    let generator = UISelectionFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        
        /* ------------ Set up Default Values ------------- */
        let defaultPrefsFile = Bundle.main.path(forResource: "defaultPreferences", ofType: "plist")
        
        let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile!)
        
        UserDefaults(suiteName:"group.DoMarsToyBox.Merces")?.register(defaults: defaultPreferences! as! [String : AnyObject])
        
        var haveShownSetupAlert = mUserDefaults?.bool(forKey: "setupAlertShown")
        
        mUserDefaults?.set(UserPreferences.sharedInstance.localSalesTax, forKey: "userLocalSalesTax")
        
        /* ------------ Accessibility/ Dynamic Type ------------- */
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(MainPage.preferredContentSizeChanged(_:)),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil)
        
        /* ------------ Display Quick Venue ------------- */
        
        varAmts.calcModel.selectedVenue = .quick
        
        varAmts.tipRateArray = tipRates(for: varAmts.calcModel.selectedVenue)
        
        varAmts.calcModel.tipRate = varAmts.tipRateArray[1]
        
        venueSelectionLabelOutlet.text = localizedName(for: varAmts.calcModel.selectedVenue)
        
        serviceRatingLabelOutlet.selectedSegmentIndex = 1
        
        updateColorValues()
        
        updateFieldValues()
        
        /* ------------ Intro -------------- */
        
        
        if haveShownSetupAlert == false && tipRates(for: .quick)[1] == 0 {
            
            let alertTitle = NSLocalizedString("WelcomeToMerces", comment: "welcome message")
            let alertMessage = NSLocalizedString("IdealExperience", comment: "best use case")
              
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("TakeToMyMerces", comment: "Take me to My Merces"), style: UIAlertAction.Style.default, handler: { (_) in
                
                let myMercesViewController = self.storyboard?.instantiateViewController(withIdentifier: "Personalize") as! MyMerces
                
                self.navigationController?.pushViewController(myMercesViewController, animated: true)
                
            }))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("DoItLater", comment: "I'll do it later"), style: UIAlertAction.Style.cancel, handler: { (_) in
                
                
                
            }))
            
            UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.set(true, forKey: "setupAlertShown")
            
            haveShownSetupAlert = UserDefaults(suiteName: "group.DoMarsToyBox.Merces")?.bool(forKey: "setupAlertShown")
            
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func preferredContentSizeChanged(_ notification: Notification) {
        updateFieldValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        updateColorValues()
        
        varAmts.tipRateArray = tipRates(for: varAmts.calcModel.selectedVenue)
        
        updateFieldValues()
        
    }
    
    @IBAction func modeSwitchButtonPressed(_ sender: UIBarButtonItem) {
        
        if UserPreferences.sharedInstance.isModeTipCalc {
            
            self.modeSwitchOutlet.isEnabled = false
            self.modeSwitchOutlet.image = UIImage(named: "shopping_bag")
            
            // move center view left
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                
                self.venueAndServiceStuffView.transform = CGAffineTransform(translationX: -self.venueAndServiceStuffView.frame.width - 8, y: 0)
                
                
            }, completion: { finished in
                
                self.venueAndServiceStuffView.alpha = 0.0
                
                // move bottom view up
                UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    
                    self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: 0, y: -self.venueAndServiceStuffView.frame.height - 8)
                    
                    
                }, completion: { finished in
                    
                    // move keypad view right
                    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                        
                        self.keypadStuffView.alpha = 1
                        
                        self.keypadStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                    }, completion: { finished in
                        UserPreferences.sharedInstance.isModeTipCalc = false
                        
                        self.modeSwitchOutlet.isEnabled = true
                        
                    })
                })
            })
            
        } else {
            
            self.modeSwitchOutlet.isEnabled = false
            self.modeSwitchOutlet.image = UIImage(named: "tipping")
            
            /* move back*/
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
               
                self.keypadStuffView.transform = CGAffineTransform(translationX: -self.keypadStuffView.frame.width - 8, y: 0)
                
            }, completion: { finished in
            
                UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    
                    //self.keypadStuffView.alpha = 0.0
                    
                    self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: { finished in
                    
                    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                        
                        self.venueAndServiceStuffView.alpha = 1.0
                        
                        self.venueAndServiceStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
                        
                    }, completion: { finished in
                        self.modeSwitchOutlet.isEnabled = true
                        
                        UserPreferences.sharedInstance.isModeTipCalc = true
                    })
                    
                })
                
            })
            
        }
        
    }
    
    /* =================== User Input Actions ====================== */
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        springForKeypadButtonsPressed(sender: sender, animations: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            let buttonTitle = sender.titleLabel!.text!
            
            switch self.userEditingThisField {
            case .subtotal:
                varAmts.arrayOfButtonsPressedForBillAmountAsString.append(buttonTitle)
                
                self.calculate(varAmts.arrayOfButtonsPressedForBillAmountAsString, activeField: self.userEditingThisField)
                
            case .salesTax:
                varAmts.arrayOfButtonsPressedForTaxAmountAsString.append(buttonTitle)
                
                self.calculate(varAmts.arrayOfButtonsPressedForTaxAmountAsString, activeField: self.userEditingThisField)
                
            case .tipRate:
                varAmts.arrayOfButtonsPressedForTipRateAsString.append(buttonTitle)
                
                self.calculate(varAmts.arrayOfButtonsPressedForTipRateAsString, activeField: self.userEditingThisField)
                
            case .partySize:
                varAmts.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.append(buttonTitle)
                
                self.calculate(varAmts.arrayOfButtonsPressedForNumberOfPeoplePayingAsString, activeField: self.userEditingThisField)
                
            default:
                return
            }
            
        })
        
    }
    
    
    @IBAction func deletePressed(_ sender: UIButton) {
        
        springForKeypadButtonsPressed(sender: sender, animations: {
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            switch self.userEditingThisField {
            case .subtotal:
                if !varAmts.arrayOfButtonsPressedForBillAmountAsString.isEmpty {
                    varAmts.arrayOfButtonsPressedForBillAmountAsString.removeLast()
                }
                
                self.calculate(varAmts.arrayOfButtonsPressedForBillAmountAsString, activeField: self.userEditingThisField)
                
            case .salesTax:
                if !varAmts.arrayOfButtonsPressedForTaxAmountAsString.isEmpty {
                    varAmts.arrayOfButtonsPressedForTaxAmountAsString.removeLast()
                }
                
                self.calculate(varAmts.arrayOfButtonsPressedForTaxAmountAsString, activeField: self.userEditingThisField)
                
            case .tipRate:
                if !varAmts.arrayOfButtonsPressedForTipRateAsString.isEmpty {
                    varAmts.arrayOfButtonsPressedForTipRateAsString.removeLast()
                }
                
                self.calculate(varAmts.arrayOfButtonsPressedForTipRateAsString, activeField: self.userEditingThisField)
                
            case .partySize:
                if !varAmts.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.isEmpty {
                    varAmts.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.removeLast()
                }
                
                self.calculate(varAmts.arrayOfButtonsPressedForNumberOfPeoplePayingAsString, activeField: self.userEditingThisField)
                
            default:
                return
            }
            
        })
        
    }
    
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        self.unscaleViewsWithSpring()
        
        self.keypadDisappear()
        
        self.updateFieldValues()
        
        self.checkTotalAmountPerPersonValue()
        
    }
    
    func checkTotalAmountPerPersonValue() {
        
        if varAmts.calcModel.moreOrLessPerPerson != 0.0 {
            
            if moreOrLessPerPersonLabel.isHidden != true {
                
                moreOrLessPerPersonLabel.isHidden = true
                
                totalAmountPerPersonTitleLabel.isHidden = false
                
                totalAmountPerPersonLabelOutlet.isHidden = false
                
            }
            
            coinsImageOutlet.isHidden = false
            
            var hold = varAmts.calcModel.moreOrLessPerPerson
            
            // $0.09 / 2 yields odd result
            
            if round(hold) == 0 {
                
                if hold > 0 { hold = 1 }
                else { hold = -1 }
                
            }
            
            if hold < 0 {
                
                coinsImageOutlet.image = UIImage(named: "coins-green")
                
            } else if hold > 0 {
                
                coinsImageOutlet.image = UIImage(named: "coins-red")
                
            } else {
                
                coinsImageOutlet.image = UIImage(named: "")
                
            }
            
            //print("Round:\(round(hold)) | Reg:\(hold) | Actual: \(varAmountsObject.moreOrLessPerPerson)")
            
        } else {
            
            moreOrLessPerPersonLabel.isHidden = true
            
            if varAmts.calcModel.partySize != 1 {
            
                totalAmountPerPersonTitleLabel.isHidden = false
                
                totalAmountPerPersonLabelOutlet.isHidden = false
                
            }
            
            coinsImageOutlet.isHidden = true
            
        }
        
    }
    
    @IBAction func venueSelected(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        /*
        10 = Bar
        11 = Dining
        12 = Taxi
        13 = Quick
        14 = Salon
        15 = Delivery
        */
        switch sender.tag {
        case 10:
            varAmts.calcModel.selectedVenue = .bar
            
        case 11:
            varAmts.calcModel.selectedVenue = .dining
            
        case 12:
            varAmts.calcModel.selectedVenue = .taxi
            
        case 13:
            varAmts.calcModel.selectedVenue = .quick
            
        case 14:
            varAmts.calcModel.selectedVenue = .salon
            
        case 15:
            varAmts.calcModel.selectedVenue = .delivery
            
        default:
            varAmts.calcModel.selectedVenue = .none
            
        }
        
        unscaleViewsWithSpring(); venueSelectorDisappear()
        
        varAmts.tipRateArray = tipRates(for: varAmts.calcModel.selectedVenue)
        
        venueSelectionLabelOutlet.text = localizedName(for: varAmts.calcModel.selectedVenue)
        
        serviceRatingLabelOutlet.selectedSegmentIndex = 1
        
        varAmts.calcModel.tipRate = varAmts.tipRateArray[serviceRatingLabelOutlet.selectedSegmentIndex]
        
        updateFieldValues()
        
    }
    
    
    /*  ======================   Button Masks  ====================== */
    
    @IBAction func billAmountMaskButton(_ sender: AnyObject) {
        
        generator.selectionChanged()
        
        keypadAppear()
        
        userEditingThisField = .subtotal
        
        varAmts.firstResponderTag = billAmountTextFieldOutlet.tag
        
        scaleViewsWithSpring(billAmountTextFieldOutlet.tag)
        
        // Here to smooth out effects of "Subtotal is Post Tax switch"
        
        self.calculate(varAmts.arrayOfButtonsPressedForBillAmountAsString, activeField: self.userEditingThisField)
        
        billAmountTextFieldOutlet.text = varAmts.updateValues().formattedBillAmount
        
    }
    
    @IBAction func taxAmountMaskButton(_ sender: AnyObject) {
        
        generator.selectionChanged()
        
        keypadAppear()
        
        userEditingThisField = .salesTax
        
        varAmts.firstResponderTag = taxAmountTextFieldOutlet.tag
        
        scaleViewsWithSpring(taxAmountTextFieldOutlet.tag)
        
    }
    
    @IBAction func numberOfPeopleMaskButton(_ sender: AnyObject) {
        
        generator.selectionChanged()
        
        keypadAppear()
        
        userEditingThisField = .partySize
        
        varAmts.firstResponderTag = numberOfPeoplePayingTextFieldOutlet.tag
        
        scaleViewsWithSpring(numberOfPeoplePayingTextFieldOutlet.tag)
        
    }
    
    @IBAction func tipRateMaskButton(_ sender: AnyObject) {
        
        generator.selectionChanged()
        
        keypadAppear()
        
        userEditingThisField = .tipRate
        
        varAmts.firstResponderTag = tipRateTextFieldOutlet.tag
        
        scaleViewsWithSpring(tipRateTextFieldOutlet.tag)
        
    }
    
    @IBAction func venueMaskButton(_ sender: AnyObject) {
        
        generator.selectionChanged()
        
        venueSelectorAppear()
        
        userEditingThisField = .none
        
        scaleViewsWithSpring(venueSelectionLabelOutlet.tag)
        
    }
    
    /* ==================== Service Rating ===================== */
    
    @IBAction func serviceRatingSegmentedControl(_ sender: UISegmentedControl) {
        
        generator.selectionChanged()
        
        // Here to smooth out effects of "Subtotal Post Tax"
        // means user selection is in place
        self.calculate(varAmts.arrayOfButtonsPressedForBillAmountAsString, activeField: .subtotal)
        
        // Here because it means user selection is done
        varAmts.updateSubtotalForPostTaxDesired()
        
        varAmts.tipRateArray = tipRates(for: varAmts.calcModel.selectedVenue)
        
        varAmts.calcModel.tipRate = varAmts.tipRateArray[sender.selectedSegmentIndex]
        
        updateFieldValues()
        
        checkTotalAmountPerPersonValue()
        
    }
    
    
    /* ------------------ Updating Values and Views -------------------- */
    
    /// Call this method whenever the user presses a button
    func calculate(_ arrayOfButtonsPressed: [String], activeField: EditableTextFields) {
        varAmts.processInput(arrayOfButtonsPressed, activeField: activeField)
        updateFieldValues()
    }
    
    /// Logic for when views appear/ disappear
    func handleTotalAmountsView() {
        
        // singlePersonTotaledAmountsViewCOnstraint
        // noTipSplitPersonViewConstraint
        //
        
        if varAmts.calcModel.tipRate == 0.00 {
            
            // hide tip amount section
            
            tipAmountsDisplayConstraint.priority = UILayoutPriority(rawValue: 980)
            tipAmountsLabelConstraint.priority = UILayoutPriority(rawValue: 980)
            
            noTipSplitPersonViewConstraint.priority = UILayoutPriority(rawValue: 970)
            noTipSplitPersonViewConstraint2.priority = UILayoutPriority(rawValue: 970)
            
            gTotalLabelConstraint.priority = UILayoutPriority(rawValue: 999)
            
            
            tipAmountLabelOutlet.isHidden = true
            
            tipAmountTitleLabel.isHidden = true
            
        } else {
            
            // show tip amount section
            
            tipAmountsDisplayConstraint.priority = UILayoutPriority(rawValue: 999)
            tipAmountsLabelConstraint.priority = UILayoutPriority(rawValue: 999)
            
            gTotalLabelConstraint.priority = UILayoutPriority(rawValue: 985)
            
            
            tipAmountLabelOutlet.isHidden = false
            
            tipAmountTitleLabel.isHidden = false
            
        }
        
        if varAmts.calcModel.partySize == 1 {
            
            // hide total per person section
            
            singlePersonTotaledAmountsViewCOnstraint.priority = UILayoutPriority(rawValue: 997)
            
            
            totalAmountPerPersonTitleLabel.isHidden = true
            
            totalAmountPerPersonLabelOutlet.isHidden = true
            
        } else {
            
            // show total per person
            
            if (varAmts.calcModel.tipRate != 0.00) {
                // show all three sections
                
                noTipSplitPersonViewConstraint.priority = UILayoutPriority(rawValue: 970)
                noTipSplitPersonViewConstraint2.priority = UILayoutPriority(rawValue: 970)
                
                gTotalLabelConstraint.priority = UILayoutPriority(rawValue: 985)
                
                singlePersonTotaledAmountsViewCOnstraint.priority = UILayoutPriority(rawValue: 990)
                
            } else {
                // show total per person and gTotal
                
                gTotalLabelConstraint.priority = UILayoutPriority(rawValue: 990)
                
                singlePersonTotaledAmountsViewCOnstraint.priority = UILayoutPriority(rawValue: 985)
                
                noTipSplitPersonViewConstraint.priority = UILayoutPriority(rawValue: 999)
                noTipSplitPersonViewConstraint2.priority = UILayoutPriority(rawValue: 999)
                
                tipAmountsDisplayConstraint.priority = UILayoutPriority(rawValue: 980)
                tipAmountsLabelConstraint.priority = UILayoutPriority(rawValue: 980)
                
            }
            
            
            
            totalAmountPerPersonTitleLabel.isHidden = false
            
            totalAmountPerPersonLabelOutlet.isHidden = false
            
        }
        
    }
    
    func updateFieldValues() {
        let userPrefs = UserPreferences.sharedInstance
        for sectionHeader in collectionSectionHeaderLabels {
            sectionHeader.font = userPrefs.checkForDynamicType(preferredFontSize: 20)
        }
        
        for inputFields in collectionInputFieldLabels {
            inputFields.font = userPrefs.checkForDynamicType(preferredFontSize: 24)
        }
        
        for totaledLabels in collectionTotaledAmountsLabels {
            totaledLabels.font = userPrefs.checkForDynamicType(preferredFontSize: 16)
        }
        
        for totaledDisplay in collectionTotaledAmountDisplays {
            totaledDisplay.font = userPrefs.checkForDynamicType(preferredFontSize: 24)
        }
        
        for venueLabels in collectionVenueLabels {
            venueLabels.font = userPrefs.checkForDynamicType(preferredFontSize: 20)
        }
        
        for keypadButtons in collectionKeypadButtons {
            keypadButtons.titleLabel?.font = userPrefs.checkForDynamicType(preferredFontSize: 28)
        }
        
        handleTotalAmountsView()
        
        /* ----- Value Output ---- */
        
        billAmountTextFieldOutlet.text = varAmts.updateValues().formattedBillAmount
        
        taxAmountTextFieldOutlet.text = varAmts.updateValues().formattedTaxAmount
        
        numberOfPeoplePayingTextFieldOutlet.text = varAmts.updateValues().numberOfPeoplePaying
        
        tipRateTextFieldOutlet.text = varAmts.updateValues().formattedTipRate
        
        venueSelectionLabelOutlet.text = localizedName(for: varAmts.calcModel.selectedVenue)
        
        
        numberOfPeoplePayingTextFieldOutlet.text = varAmts.updateValues().numberOfPeoplePaying
        
        tipAmountLabelOutlet.text = varAmts.updateValues().tipAmount
        
        
        totalAmountLabelOutlet.text = varAmts.updateValues().totalAmount
        
        totalAmountPerPersonLabelOutlet.text = varAmts.updateValues().totalAmountPerPerson
        
        if varAmts.calcModel.moreOrLessPerPerson < 0 {
            coinsImageOutlet.image = UIImage(named: "coins-green")
        } else if varAmts.calcModel.moreOrLessPerPerson > 0 {
            coinsImageOutlet.image = UIImage(named: "coins-red")
        } else {
            coinsImageOutlet.isHidden = true
        }
    }

    /// This method updates the colors used throughout the app in response to user changing their theme
    func updateColorValues() {
        
        /* ------------ Navigation Bar Coloring ------------- */
        
        // Full Nav Bar Coloring
        self.navigationController?.navigationBar.barTintColor = coloringThemes.getMainColor()
        
        // Background Coloring
        self.view.backgroundColor = coloringThemes.getBackgroundColor()
        
        
        // Title Coloring
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)!]
        
        
        // Back Button Coloring
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
        
        /* other */
        
        serviceRatingLabelOutlet.tintColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
        //UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
        
//        serviceRatingLabelOutlet.layer.borderColor = self.view.backgroundColor?.cgColor
        serviceRatingLabelOutlet.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
       
        
        for sectionHeader in collectionSectionHeaderLabels {
            
            sectionHeader.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
//            UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
            
        }
        
        /*------ Corners and Borders ------*/
        
        // for billTax, Venue, and totaledAmounts Views
        for MainViews in collectionMainViews {
            
            MainViews.layer.cornerRadius = 5
            
            MainViews.layer.borderWidth = 1
            
            MainViews.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor!, isFlat: true).cgColor
            
            MainViews.backgroundColor = coloringThemes.getViewBackgroundColor()
            
        }
        
        for inputFields in collectionInputFieldLabels {
            
            inputFields.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
            
            inputFields.layer.cornerRadius = 2.5
            
            inputFields.layer.borderWidth = 1
            
            inputFields.layer.borderColor = inputFields.textColor!.cgColor
            
        }
        
        for totaledAmountsLabels in collectionTotaledAmountsLabels {
            
            totaledAmountsLabels.layer.cornerRadius = 2.5
            
            totaledAmountsLabels.layer.borderWidth = 1
            
            totaledAmountsLabels.layer.borderColor = totaledAmountsLabels.textColor!.cgColor
            
        }
        
        for totaledAmountsDisplays in collectionTotaledAmountDisplays {
            
            totaledAmountsDisplays.layer.cornerRadius = 2.5
            
            totaledAmountsDisplays.layer.borderWidth = 1
            
            totaledAmountsDisplays.layer.borderColor = totaledAmountsDisplays.textColor!.cgColor
            
        }
        
        for totaledDisplays in collectionTotaledAmountDisplays {
            
            totaledDisplays.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
            //UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
            
        }
        
        for totaledAmounts in collectionTotaledAmountsLabels {
        
            totaledAmounts.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getViewBackgroundColor(), isFlat: true)
            //UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true)
            
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
        
        /* -------- VenueView coloring -------- */
        
        venuesStuffView.backgroundColor = coloringThemes.getMainColor()
        
        venuesStuffView.layer.cornerRadius = 5
        
        venuesStuffView.layer.borderWidth = 2.5
        
        venuesStuffView.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true).cgColor
        
        venuesStuffView.backgroundColor = coloringThemes.getMainColor()
  

        for venueViews in collectionVenueViews {
            
            if "\(String(describing: UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)))" == "UIExtendedSRGBColorSpace 0.15 0.15 0.15 1" {
                
                venueViews.backgroundColor = coloringThemes.getMainColor()
                
            } else {
            
                venueViews.backgroundColor = UIColor.white //UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true)
                
            }
            
            venueViews.layer.cornerRadius = 7.5
            
            venueViews.layer.borderWidth = 2.5
            
            venueViews.layer.borderColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getMainColor(), isFlat: true).cgColor
            
        }
        
        if UserPreferences.sharedInstance.localSalesTax != 0.0 {
        
            taxAmountMaskOutlet.isEnabled = false
            
            taxAmountTextFieldOutlet.backgroundColor = tipAmountLabelOutlet.backgroundColor
            
        } else {
            
            taxAmountMaskOutlet.isEnabled = true
            
            taxAmountTextFieldOutlet.backgroundColor = UIColor.clear
            
        }
        
    }
    
    
   /* ====================== ANIMATIONS ===================== */
    
    /* ------------------------ Input Fields Appear & Dissapear ------------------ */
    
    func keypadAppear() {
        let userPrefs = UserPreferences.sharedInstance
        if venueSelectorIsUp == true {
            
            venueSelectorIsUp = false; venuesStuffView.alpha = 1.0
            
            totaledAmountsStuffView.isHidden = false; totaledAmountsStuffView.alpha = 1.0
            
            keypadStuffView.isHidden = false; keypadStuffView.alpha = 1.0
            
            if userPrefs.isModeTipCalc {
                totaledAmountsStuffView.transform = CGAffineTransform(translationX: -self.view.frame.width , y: 0)
            }
            
            keypadStuffView.transform = CGAffineTransform(translationX: (-self.view.frame.width - self.view.frame.width) , y: 0)
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                
                self.venuesStuffView.transform = CGAffineTransform(translationX: (self.view.frame.width + self.view.frame.width), y: 0)
                
                if userPrefs.isModeTipCalc {
                    self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: self.view.frame.width , y: 0)
                }
                
                self.keypadStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
                
                }, completion: { finished in
                    
                    self.venuesStuffView.alpha = 0.0
                    
                    if userPrefs.isModeTipCalc {
                        self.totaledAmountsStuffView.alpha = 0.0
                    }
            })
            
            
        } else if keypadIsUp != true {
            
            
            totaledAmountsStuffView.alpha = 1.0
            
            
            keypadStuffView.isHidden = false; keypadStuffView.alpha = 1.0
            
            keypadStuffView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                
                if userPrefs.isModeTipCalc {
                    self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: self.view.frame.width , y: 0)
                }
                
                self.keypadStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
                
                
                }, completion: { finished in
                    
                    if userPrefs.isModeTipCalc {
                        self.totaledAmountsStuffView.alpha = 0.0
                    }
                    
            })
            
        }
        
        keypadIsUp = true
        
    }
    
    func keypadDisappear() {
        let userPrefs = UserPreferences.sharedInstance
        keypadIsUp = false; keypadStuffView.alpha = 1.0
        
        totaledAmountsStuffView.isHidden = false; totaledAmountsStuffView.alpha = 1.0
        
        // In case user switched from Venue selector to keypad, 
        // Make sure Totaled Amount View is in correct spot for anim.
        if userPrefs.isModeTipCalc {
            self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: self.view.frame.width , y: 0)
        }
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
            
            self.keypadStuffView.transform = CGAffineTransform(translationX: -self.view.frame.width , y: 0)
            if userPrefs.isModeTipCalc {
                self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
        }, completion: { finished in
            
            self.keypadStuffView.alpha = 0.0
            
        })
        
    }
    
    func venueSelectorAppear() {
        
        if keypadIsUp == true {
            
            keypadIsUp = false; keypadStuffView.alpha = 1.0
            
            venuesStuffView.isHidden = false; venuesStuffView.alpha = 1.0
            
            totaledAmountsStuffView.isHidden = false; totaledAmountsStuffView.alpha = 1.0
            
            totaledAmountsStuffView.transform = CGAffineTransform(translationX: self.view.frame.width , y: 0)
            
            venuesStuffView.transform = CGAffineTransform(translationX: (self.view.frame.width + self.view.frame.width) , y: 0)
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                
                self.keypadStuffView.transform = CGAffineTransform(translationX: (-self.view.frame.width - self.view.frame.width) , y: 0)
                
                self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: -self.view.frame.width , y: 0)
                
                self.venuesStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
                
                }, completion: { finished in
                    
                    self.totaledAmountsStuffView.alpha = 0.0
                    
                    self.keypadStuffView.alpha = 0.0
                    
            })
            
        } else if venueSelectorIsUp != true {
            
            totaledAmountsStuffView.alpha = 1.0
            
            venuesStuffView.isHidden = false; venuesStuffView.alpha = 1.0
            
            venuesStuffView.transform = CGAffineTransform(translationX: self.view.frame.width , y: 0)
            
            //venuesStuffView.transform = CGAffineTransform(translationX: 0, y: 200)
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                
                self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                
                self.venuesStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
                
                }, completion: { finished in
                    
                    self.totaledAmountsStuffView.alpha = 0.0
                    
            })
            
        }
        
        venueSelectorIsUp = true
        
    }
    
    func venueSelectorDisappear() {
        
        venueSelectorIsUp = false; venuesStuffView.alpha = 1.0
        
        totaledAmountsStuffView.isHidden = false; totaledAmountsStuffView.alpha = 1.0
        
        // In case user switched from Keypad to Venue selector,
        // Make sure Totaled Amount View is in correct spot for anim.
        self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
            
            self.venuesStuffView.transform = CGAffineTransform(translationX: self.view.frame.width , y: 0)
            
            self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
            
            }, completion: { finished in
                
                self.venuesStuffView.alpha = 0.0
                
        })
        
    }
    
    /* ------------------------ View Scaling/ Springing --------------------- */
    
    func scaleViewsWithSpring(_ editedViewsTag: Int) {
        
        // Here to smooth out effects of "Subtotal Post Tax"
        // means user selection is in place
        self.calculate(varAmts.arrayOfButtonsPressedForBillAmountAsString, activeField: .subtotal)
        
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
        
        for sectionHeaders in collectionSectionHeaderLabels {
            
            spring(0.7, animations: {
                
                if sectionHeaders.tag != 0 {
                    
                    if editedViewsTag != sectionHeaders.tag {
                        
                        sectionHeaders.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        
                    } else {
                        
                        sectionHeaders.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        
                    }
                }
                
            })
            
        }
        
    }
    
    func unscaleViewsWithSpring() {
        
        // Here because it means user selection is done
        varAmts.updateSubtotalForPostTaxDesired()
        
        for textFields in collectionInputFieldLabels {
            
            spring(0.7, animations:  {
                
                textFields.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
                textFields.layer.borderWidth = 1.0
                
            })
            
        }
        
        for sectionHeaders in collectionSectionHeaderLabels {
            
            spring(0.7, animations: {
                
                sectionHeaders.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
            })
            
        }
        
    }
    
    @IBAction func totaledAmountsLabelWasTapped(_ recognizer:UITapGestureRecognizer) {
        
        totalAmountsViewIsFull = !totalAmountsViewIsFull
        
        self.coinsImageOutlet.isHidden = true
        
        // if user is looking at MOLPP message, change back
        moreOrLessPerPersonLabel.isHidden = true
        
        if varAmts.calcModel.partySize > 1 {
        
            totalAmountPerPersonTitleLabel.isHidden = false
            
            totalAmountPerPersonLabelOutlet.isHidden = false
            
        }
        
//        if totalAmountsViewIsFull == true {
//            
//            UIImpactFeedbackGenerator(style: .light).impactOccurred()
//            
//            settingsIconOutlet.isEnabled = false
//            modeSwitchOutlet.isEnabled = false
//            
//            origTipAmountTitleLabelHeight = self.tipAmountTitleLabel.frame.height
//            
//            origTipAmountTitleLabelY = self.tipAmountTitleLabel.frame.origin.y
//            
//            origTipAmountLabelHeight = self.tipAmountLabelOutlet.frame.height
//            
//            origTipAmountLabelY = self.tipAmountLabelOutlet.frame.origin.y
//            
//            origTotalAmountPerPersonTitleLabelHeight = self.totalAmountPerPersonTitleLabel.frame.height
//            
//            origTotalAmountPerPersonTitleLabelY = self.totalAmountPerPersonTitleLabel.frame.origin.y
//            
//            origTotalAmountPerPersonalLabelHeight = self.totalAmountPerPersonLabelOutlet.frame.height
//            
//            origTotalAmountPerPersonalLabelY = self.totalAmountPerPersonLabelOutlet.frame.origin.y
//            
//            origTotalAmountTitleLabelHeight = self.totalAmountTitleLabel.frame.height
//            
//            origTotalAmountTitleLabelY = self.totalAmountTitleLabel.frame.origin.y
//            
//            origTotalAmountLabelHeight = self.totalAmountLabelOutlet.frame.height
//            
//            origTotalAmountLabelY = self.totalAmountLabelOutlet.frame.origin.y
//            
//            origTotaledAmountsFrameHeight = self.totaledAmountsStuffView.frame.height
//            
//            origTotaledAmountsFrameWidth = self.totaledAmountsStuffView.frame.width
//            
//            origTotaledAmountsFrameY = self.totaledAmountsStuffView.frame.origin.y
//            
//            origTotaledAmountsLabelHeight = self.totaledAmountsLabel.frame.height
//            
//            origTotaledAmountsLabelWidth = self.totaledAmountsLabel.frame.width
//            
//            origTotaledAmountsLabelY = self.totaledAmountsLabel.frame.origin.y
//            
//            
//            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
//                
//                self.billTaxPeopleStuffView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
//                
//                self.venueAndServiceStuffView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
//                
//                }, completion: {finished in
//                    
//                    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
//                        
//                        
//                        //Top Portion of View is smaller when in landscape, so need to check the device orientation
//                        
//                        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//                            
//                            self.origTotaledAmountsLabelWidth = self.totaledAmountsLabel.frame.width
//                            
//                            self.totaledAmountsStuffView.frame = CGRect(x: 8,
//                                y: ((self.navigationController?.navigationBar.frame.size.height)! + 8),
//                                width: self.totaledAmountsStuffView.frame.width,
//                                height: self.view.frame.height - ((self.navigationController?.navigationBar.frame.size.height)! + 16))
//                            
//                        } else {
//                            
//                            self.totaledAmountsStuffView.frame = CGRect(x: 8,
//                                y: ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height + 8),
//                                width: self.totaledAmountsStuffView.frame.width,
//                                height: self.view.frame.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height + 16))
//                            
//                        }
//                        
//                        //Added 16 to the height reducations to make up for the distances of heighest and lowest views from the frame
//                        
//                        
//                        }, completion: {finished in
//                            
//                            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
//                                
//                                self.totalAmountTitleLabel.frame =
//                                    CGRect(x: 8,
//                                        y: self.totaledAmountsStuffView.frame.height - (self.totaledAmountsStuffView.frame.height / 4) - 8,
//                                        width: self.tipAmountTitleLabel.frame.width,
//                                        height: self.totaledAmountsStuffView.frame.height / 4)
//                                
//                                
//                                self.totalAmountLabelOutlet.frame =
//                                    CGRect(x: self.totalAmountTitleLabel.frame.width + 16,
//                                        y: self.totaledAmountsStuffView.frame.height - (self.totaledAmountsStuffView.frame.height / 4) - 8 ,
//                                        width: self.tipAmountLabelOutlet.frame.width,
//                                        height: self.totaledAmountsStuffView.frame.height / 4)
//                                
//                                
//                                }, completion: { finished in
//                                    
//                                    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
//                                        
//                                        if varAmountsObject.moreOrLessPerPerson != 1 {
//                          
//                                            self.totalAmountPerPersonTitleLabel.frame =
//                                                CGRect(x: 8,
//                                                    y: self.totaledAmountsStuffView.frame.height - (self.totaledAmountsStuffView.frame.height / 4) - self.totalAmountLabelOutlet.frame.height - 16,
//                                                    width: self.tipAmountTitleLabel.frame.width,
//                                                    height: self.totaledAmountsStuffView.frame.height / 4)
//                                            
//                                            
//                                            self.totalAmountPerPersonLabelOutlet.frame =
//                                                CGRect(x: self.totalAmountTitleLabel.frame.width + 16,
//                                                    y: self.totaledAmountsStuffView.frame.height - (self.totaledAmountsStuffView.frame.height / 4) - self.totalAmountLabelOutlet.frame.height - 16,
//                                                    width: self.tipAmountLabelOutlet.frame.width,
//                                                    height: self.totaledAmountsStuffView.frame.height / 4)
//                                
//                                            
//    //                                        self.totalAmountPerPersonTitleLabel.alpha = 1
//    //                                        
//    //                                        self.totalAmountPerPersonLabelOutlet.alpha = 1
//                                            
//                                        }
//                                        
//                                        }, completion: {finished in
//                                            
//                                            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
//                                                
//                                                self.tipAmountTitleLabel.frame =
//                                                    CGRect(x: 8,
//                                                        y: self.totaledAmountsStuffView.frame.height - (self.totaledAmountsStuffView.frame.height / 4) - self.totalAmountLabelOutlet.frame.height - self.totalAmountPerPersonTitleLabel.frame.height - 24,
//                                                        width: self.tipAmountTitleLabel.frame.width,
//                                                        height: self.totaledAmountsStuffView.frame.height / 4)
//                                                
//                                                self.tipAmountLabelOutlet.frame =
//                                                    CGRect(x: self.totalAmountTitleLabel.frame.width + 16,
//                                                        y: self.totaledAmountsStuffView.frame.height - (self.totaledAmountsStuffView.frame.height / 4) - self.totalAmountLabelOutlet.frame.height - self.totalAmountPerPersonTitleLabel.frame.height - 24,
//                                                        width: self.tipAmountLabelOutlet.frame.width,
//                                                        height: self.totaledAmountsStuffView.frame.height / 4)
//                                                
//                                                self.tipAmountLabelOutlet.alpha = 1
//                                                
//                                                self.tipAmountTitleLabel.alpha = 1
//                                                
//                                                }, completion: {finished in
//                                                    
//                                                    spring(0.9, animations: {
//                                                        
//                                                        self.totaledAmountsLabel.frame =
//                                                            CGRect(x: 8,
//                                                                y: self.totaledAmountsStuffView.frame.height - (self.totaledAmountsStuffView.frame.height / 4) - self.totalAmountLabelOutlet.frame.height - self.totalAmountPerPersonTitleLabel.frame.height - self.tipAmountTitleLabel.frame.height - 24,
//                                                                width: self.tipAmountLabelOutlet.frame.width + self.tipAmountTitleLabel.frame.width + 8,
//                                                                height: (self.totaledAmountsStuffView.frame.height / 4) + 8)
//                                     
//                                                    })
//                                            })
//                                    })
//                            })
//                    })
//                    
//                    
//            })
//            
//        }
//            
//        else {
//            
//            UIView.animate(withDuration: 1.1, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
//                
//                self.tipAmountTitleLabel.frame =
//                    CGRect(x: 8,
//                        y: self.origTipAmountTitleLabelY,
//                        width: self.tipAmountTitleLabel.frame.width,
//                        height: self.origTipAmountTitleLabelHeight)
//                
//                self.tipAmountLabelOutlet.frame =
//                    CGRect(x: self.totalAmountTitleLabel.frame.width + 16,
//                        y: self.origTipAmountLabelY,
//                        width: self.tipAmountLabelOutlet.frame.width,
//                        height: self.origTipAmountLabelHeight)
//                
//                self.totalAmountPerPersonTitleLabel.frame =
//                    CGRect(x: 8,
//                        y: self.origTotalAmountPerPersonTitleLabelY,
//                        width: self.totalAmountPerPersonTitleLabel.frame.width,
//                        height: self.origTotalAmountPerPersonTitleLabelHeight)
//                
//                
//                self.totalAmountPerPersonLabelOutlet.frame =
//                    CGRect(x: self.totalAmountTitleLabel.frame.width + 16,
//                        y: self.origTotalAmountPerPersonalLabelY,
//                        width: self.totalAmountPerPersonLabelOutlet.frame.width,
//                        height: self.origTotalAmountPerPersonalLabelHeight)
//                
//                self.totalAmountTitleLabel.frame =
//                    CGRect(x: 8,
//                        y: self.origTotalAmountTitleLabelY,
//                        width: self.totalAmountTitleLabel.frame.width,
//                        height: self.origTotalAmountTitleLabelHeight)
//                
//                
//                self.totalAmountLabelOutlet.frame =
//                    CGRect(x: self.totalAmountTitleLabel.frame.width + 16,
//                        y: self.origTotalAmountLabelY,
//                        width: self.totalAmountLabelOutlet.frame.width,
//                        height: self.origTotalAmountLabelHeight)
//                
//                self.totaledAmountsLabel.frame =
//                    CGRect(x: 8,
//                        y: self.origTotaledAmountsLabelY,
//                        width: self.origTotaledAmountsLabelWidth,
//                        height: self.origTotaledAmountsLabelHeight)
//                
//                
//                }, completion: {finished in
//                    
//                    
//                    UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.curveEaseIn, animations: {
//                        
//                        self.totaledAmountsStuffView.frame = CGRect(x: 8,
//                            y: self.origTotaledAmountsFrameY,
//                            width: self.origTotaledAmountsFrameWidth,
//                            height: self.origTotaledAmountsFrameHeight)
//                        
//                        self.billTaxPeopleStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
//                        
//                        self.billTaxPeopleStuffView.alpha = 1
//                        
//                        self.venueAndServiceStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
//                        
//                        self.venueAndServiceStuffView.alpha = 1
//                        
//                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
//                       
//                        
//                        }, completion: {finished in
//                            
//                            self.settingsIconOutlet.isEnabled = true
//                            self.modeSwitchOutlet.isEnabled = true
//                            
//                            //self.coinsImageOutlet.isHidden = false
//                            
//                            self.checkTotalAmountPerPersonValue()
//                            
//                            self.totaledAmountsStuffView.frame = CGRect(x: 8,
//                                y: self.origTotaledAmountsFrameY,
//                                width: self.origTotaledAmountsFrameWidth,
//                                height: self.origTotaledAmountsFrameHeight)
//                            
//                            self.totaledAmountsStuffView.transform = CGAffineTransform(translationX: 0, y: 0)
//                            
//                    })
//                    
//                    
//            })
//            
//        }

        
    }
    
    @IBAction func coinsImageWasTapped(_ recognizer:UITapGestureRecognizer) {
        
        if varAmts.calcModel.moreOrLessPerPerson != 0.0 {
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            springForInputViews(0.3, animations: {
            
                self.coinsImageOutlet.isHidden = true
                
                self.moreOrLessPerPersonLabel.isHidden = false
                
                self.totalAmountPerPersonTitleLabel.isHidden = true
                
                self.totalAmountPerPersonLabelOutlet.isHidden = true
                
            })
            
            var hold = varAmts.calcModel.moreOrLessPerPerson
            
            if round(hold) == 0 {
                
                if hold > 0 { hold = 1 }
                else { hold = -1 }
                
            }
            
            let absValHold = Int(abs(round(hold)))
            
            if hold < 0 {
                
                if absValHold == 1 {
                    
                    moreOrLessPerPersonLabel.text = "Results in \(absValHold) penny extra"
                    
                } else {
                    
                    moreOrLessPerPersonLabel.text = "Results in \(absValHold) pennies extra"
                    
                }
                
            } else {
                
                if absValHold == 1 {
                    
                    moreOrLessPerPersonLabel.text = "Result will need \(absValHold) more penny"
                    
                } else {
                    
                    moreOrLessPerPersonLabel.text = "Result will need \(absValHold) more pennies"
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func MOLPPLabelWasTapped(_ recognizer:UITapGestureRecognizer) {
        
        if moreOrLessPerPersonLabel.isHidden == false {
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            moreOrLessPerPersonLabel.isHidden = true
            
            totalAmountPerPersonTitleLabel.isHidden = false
            
            totalAmountPerPersonLabelOutlet.isHidden = false
            
            coinsImageOutlet.isHidden = false
            
        }
        
    }
    
    /* -------------------------------- Alert View Stuff ------------------------------ */
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            
            //Code for a regular iOS Alert
            
            let alertTitle = NSLocalizedString("JustToBeSafe", comment: "safety check")
            let alertMessage = NSLocalizedString("WantToClearValues", comment: "safety message")
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "No"), style: UIAlertAction.Style.default, handler: { (_) in
                
                
                
            }))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Yes"), style: UIAlertAction.Style.destructive, handler: { (_) in
                
                varAmts.resetValues()
                
                self.venueSelectionLabelOutlet.text = localizedName(for: varAmts.calcModel.selectedVenue)
                
                self.updateFieldValues()
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }


}
