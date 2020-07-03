//
//  TodayViewController.swift
//  TipTokWidget
//
//  Created by Donovan McCray on 1/16/17.
//  Copyright © 2017 DoMarsToyBox. All rights reserved.
//

import UIKit
import NotificationCenter

let varAmountsObject = InputProcessing()

//let coloringThemes = Themes()

let generator = UISelectionFeedbackGenerator()

class TodayViewController: UIViewController, NCWidgetProviding {

    /*
     0 = subtotal
     1 = tip rate
     2 =
     */

    var amountIndexer = 1

    var currentDisplayIsExpanded = false

    /* ----------------- Constraint Outlets --------------------- */

    @IBOutlet var numOfPeopleWidthConstraint: NSLayoutConstraint!

    @IBOutlet var subTBottomConstraint: NSLayoutConstraint!

    @IBOutlet var tipAmountTrailingConstraint: NSLayoutConstraint!
    /* ----------------- Collection Outlets --------------------- */
    @IBOutlet var collectionDisplayViewLabels: [UILabel]!

    @IBOutlet var collectionInputDisplayLabels: [UILabel]!

    @IBOutlet var collectionKeypadButtons: [UIButton]!

    @IBOutlet var collectionExpandedViewItems: [UILabel]!

    @IBOutlet var collectionCompactViewBottomItems: [UILabel]!


    /* ----------------- Outlets -------------------- */

    @IBOutlet var subtotalLabelOutlet: UILabel!


    @IBOutlet var subtotalDisplayOutlet: UILabel!
    @IBOutlet var tipRateDisplayOutlet: UILabel!
    @IBOutlet var grandTotalDisplayOutlet: UILabel!

    @IBOutlet var numOfPeopleDisplayOutlet: UILabel!
    @IBOutlet var salesTaxDisplayOutlet: UILabel!
    @IBOutlet var tipAmountDisplayOutlet: UILabel!
    @IBOutlet var totalAmountPerPersonDisplayOutlet: UILabel!

    @IBOutlet var salesTaxLabelOutlet: UILabel!
    @IBOutlet var numOfPeopleLabelOutlet: UILabel!
    @IBOutlet var tipAmountLabelOutlet: UILabel!
    @IBOutlet var totalAmountPerPersonLabelOutlet: UILabel!

    @IBOutlet var displayViewOutlet: UIView!
    @IBOutlet weak var keypadViewOutlet: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.

        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded

        /* ------------ Set up Default Values ------------- */
        let defaultPrefsFile = Bundle.main.path(forResource: "defaultPreferences", ofType: "plist")

        let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile!)

        UserDefaults(suiteName:"group.DoMarsToyBox.Merces")?.register(defaults: defaultPreferences! as! [String : AnyObject])

        for inputDisplays in collectionInputDisplayLabels {

            inputDisplays.layer.cornerRadius = 2.5

            inputDisplays.layer.borderWidth = 1

            inputDisplays.layer.borderColor = inputDisplays.textColor!.cgColor

            if inputDisplays.tag <= 6 {
                inputDisplays.backgroundColor = UIColor.white
            }
        }

        for item in collectionCompactViewBottomItems {
            item.translatesAutoresizingMaskIntoConstraints = false
        }

        for item in collectionExpandedViewItems {
            item.translatesAutoresizingMaskIntoConstraints = false
        }

        updateColors()

        /* ------------ Display Quick Venue ------------- */

        varAmountsObject.calcModel.selectedVenue = .quick

        varAmountsObject.tipRateArray = Tipping.sharedInstance.tipRates(for: varAmountsObject.calcModel.selectedVenue)

        varAmountsObject.calcModel.tipRate = varAmountsObject.tipRateArray[1]

    }

    // "Show More" and "Show Less" changes

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {

        if (activeDisplayMode == NCWidgetDisplayMode.compact) {

            currentDisplayIsExpanded = false

            self.preferredContentSize = maxSize

            for item in collectionExpandedViewItems {
                item.isHidden = true
            }

            subTBottomConstraint.priority = UILayoutPriority(rawValue: 997)

            view.layoutIfNeeded()

        } else {

            currentDisplayIsExpanded = true

            subTBottomConstraint.priority = UILayoutPriority(rawValue: 990)

            view.layoutIfNeeded()

            self.preferredContentSize = CGSize(width: maxSize.width, height: 250)

            for item in collectionExpandedViewItems {

                item.isHidden = false

            }

            if varAmountsObject.calcModel.partySize > 1 {

                tipAmountTrailingConstraint.priority = UILayoutPriority(rawValue: 990)

                totalAmountPerPersonLabelOutlet.isHidden = false

                totalAmountPerPersonDisplayOutlet.isHidden = false

                numOfPeopleWidthConstraint.priority = UILayoutPriority(rawValue: 990)

            } else {

                tipAmountTrailingConstraint.priority = UILayoutPriority(rawValue: 997)

                totalAmountPerPersonDisplayOutlet.isHidden = true

                totalAmountPerPersonLabelOutlet.isHidden = true

                numOfPeopleWidthConstraint.priority = UILayoutPriority(rawValue: 997)

            }

        }

    }


    override func viewDidAppear(_ animated: Bool) {

        for keypadButtons in collectionKeypadButtons {

            keypadButtons.setTitleColor(UIColor.white, for: UIControl.State.normal)

            keypadButtons.layer.borderWidth = 0.5

            keypadButtons.layer.borderColor = keypadViewOutlet.backgroundColor?.cgColor

//            keypadButtons.backgroundColor = coloringThemes.mainColor

        }

        updateDisplay()

        updateColors()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.newData)
    }

    /* -------- Button Functions --------- */
    @IBAction func buttonTouched(_ sender: UIButton) {

        //        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        //
        //            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        //
        //        }, completion: { finished in
        //
        //        })

    }

    @IBAction func touchCancel(_ sender: UIButton) {

        sender.transform = CGAffineTransform.identity

    }

    @IBAction func buttonPressed(_ sender: UIButton) {

        springForKeypadButtonsPressed(sender: sender, animations: {

            let buttonTitle = sender.titleLabel!.text!

            /*
             1 = subtotal
             2 = sales tax
             3 = # of people
             4 = tip rate
             8 = grand total
             9 = tip amount
             */

            if self.amountIndexer == 1 {
                // Bill Amount
                varAmountsObject.arrayOfButtonsPressedForBillAmountAsString.append(buttonTitle)
            } else if self.amountIndexer == 4 {
                // Tip Rate
                varAmountsObject.arrayOfButtonsPressedForTipRateAsString.append(buttonTitle)
            } else if self.amountIndexer == 2 {
                // Sales Tax
                varAmountsObject.arrayOfButtonsPressedForTaxAmountAsString.append(buttonTitle)
            } else if self.amountIndexer == 3 {
                // # of people
                varAmountsObject.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.append(buttonTitle)
            }

            self.updateDisplay()

        })

    }

    @IBAction func deletePressed(_ sender: UIButton) {

        springForKeypadButtonsPressed(sender: sender, animations: {

            if self.amountIndexer == 1 {
                // Bill Amount
                if !varAmountsObject.arrayOfButtonsPressedForBillAmountAsString.isEmpty {
                    varAmountsObject.arrayOfButtonsPressedForBillAmountAsString.removeLast()
                }

            } else if self.amountIndexer == 4 {
                // Tip Rate
                if !varAmountsObject.arrayOfButtonsPressedForTipRateAsString.isEmpty {
                    varAmountsObject.arrayOfButtonsPressedForTipRateAsString.removeLast()
                }
            }  else if self.amountIndexer == 2 {
                // Sales Tax
                if !varAmountsObject.arrayOfButtonsPressedForTaxAmountAsString.isEmpty {
                    varAmountsObject.arrayOfButtonsPressedForTaxAmountAsString.removeLast()
                }
            } else if self.amountIndexer == 3 {
                // # of people
                if !varAmountsObject.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.isEmpty {
                    varAmountsObject.arrayOfButtonsPressedForNumberOfPeoplePayingAsString.removeLast()
                }
            }
            self.updateDisplay()
        })
    }

    @IBAction func nextItemButtonPressed(sender: UIButton) {

        self.subtotalDisplayOutlet.text = nForm.roundForCurrency(number: varAmountsObject.calcModel.subtotal)

        springForKeypadButtonsPressed(sender: sender, animations: {

            if self.currentDisplayIsExpanded == false {

                // in compact view, only subtotal and tip rate are present
                // only values should be 1 and 4
                if self.amountIndexer == 1 { self.amountIndexer = 4}
                else { self.amountIndexer = 1 }

            } else if self.currentDisplayIsExpanded == true {

                if self.amountIndexer != 4 {

                    self.amountIndexer += 1

                    if (UserPreferences.sharedInstance.localSalesTax != 0.0) && (self.amountIndexer == 2) {
                        self.amountIndexer += 1
                    }

                    self.scaleViews(editedViewsTag: self.amountIndexer)

                    varAmountsObject.firstResponderTag = self.amountIndexer

                } else {

                    self.amountIndexer = 1

                    self.scaleViews(editedViewsTag: 0)

                    varAmountsObject.firstResponderTag = 1
                }
            }
            self.updateDisplay()
        })
    }

    func scaleViews (editedViewsTag: Int) {

        /*
         1 = subtotal
         2 = sales tax
         3 = # of people
         4 = tip rate
         8 = grand total
         9 = tip amount
         */

        for inputDisplays in collectionInputDisplayLabels {

            if editedViewsTag != inputDisplays.tag {

                inputDisplays.layer.borderColor = UIColor.black.cgColor

                inputDisplays.layer.borderWidth = 1

            } else {

//                inputDisplays.layer.borderColor = coloringThemes.mainColor.cgColor

                inputDisplays.layer.borderWidth = 3

            }

        }

    }

    func updateDisplay() {

        scaleViews(editedViewsTag: amountIndexer)

        if varAmountsObject.calcModel.partySize > 1 {

            tipAmountTrailingConstraint.priority = UILayoutPriority(rawValue: 990)

            totalAmountPerPersonLabelOutlet.isHidden = false

            totalAmountPerPersonDisplayOutlet.isHidden = false

            numOfPeopleWidthConstraint.priority = UILayoutPriority(rawValue: 990)

        } else {

            tipAmountTrailingConstraint.priority = UILayoutPriority(rawValue: 997)

            totalAmountPerPersonDisplayOutlet.isHidden = true

            totalAmountPerPersonLabelOutlet.isHidden = true

            numOfPeopleWidthConstraint.priority = UILayoutPriority(rawValue: 997)

        }

        /* ---- Value Output --- */

        subtotalDisplayOutlet.text = nForm.roundForCurrency(number: varAmountsObject.calcModel.subtotal)

        tipRateDisplayOutlet.text = nForm.roundForPercentWithTwoDecimalPlaces(varAmountsObject.calcModel.tipRate)

        grandTotalDisplayOutlet.text = nForm.roundForCurrency(number: varAmountsObject.calcModel.totalAmount)

        numOfPeopleDisplayOutlet.text = nForm.formatIntegerNumbers(varAmountsObject.calcModel.partySize)

        salesTaxDisplayOutlet.text = nForm.roundForCurrency(number: varAmountsObject.calcModel.taxAmount)

        tipAmountDisplayOutlet.text = nForm.roundForCurrency(number: varAmountsObject.calcModel.tipAmount)

        totalAmountPerPersonDisplayOutlet.text = nForm.roundForCurrency(number: varAmountsObject.calcModel.totalAmountPerPerson)

    }

    func updateColors() {

        displayViewOutlet.backgroundColor = UIColor.white

        keypadViewOutlet.backgroundColor = UIColor.black
        
        for inputLabel in collectionInputDisplayLabels {
            inputLabel.textColor = UIColor.black
        }
        
        for displayOutlet in collectionDisplayViewLabels {
            displayOutlet.textColor = UIColor.black
        }

        if UserPreferences.sharedInstance.localSalesTax != 0.0 {

            salesTaxDisplayOutlet.backgroundColor = grandTotalDisplayOutlet.backgroundColor

        }

    }

}

