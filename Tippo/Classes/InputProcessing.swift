//
//  VariableAmountsClass.swift
//  TipTok
//
//  Created by Donovan McCray on 2/22/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

enum InputStyles {
    case Currency
    case TwoDecimalPercent
    case ThreeDecimalPercent
    case Integer
}

enum EditableTextFields: CaseIterable, Hashable, Identifiable {
    case subtotal
    case salesTax
    case partySize
    case tipRate
    case venue
    case localTax
    case badTip
    case goodTip
    case greatTip
    case newBadTip
    case newGoodTip
    case newGreatTip
    case none
    
    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }
    
    var id: EditableTextFields { self }
}

class InputProcessing: ObservableObject
{
    static let sharedInstance = InputProcessing()
    
    /* Objects */
    let calcModel = CalculationsModel.sharedInstance
    let venueEditor = VenueEditor.sharedInstance
    
    /* Variables */
    var tipRateArray: [Double]
    @Published var activeField: EditableTextFields = .none
    
    var arrayOfButtonsPressedForBillAmountAsString: [String] {
        didSet {
            calcModel.subtotal = processInput(arrayOfButtonsPressedForBillAmountAsString, inputStyle: .Currency)
        }
    }
    var arrayOfButtonsPressedForTaxAmountAsString: [String] {
        didSet {
            calcModel.taxAmount = processInput(arrayOfButtonsPressedForTaxAmountAsString, inputStyle: .Currency)
        }
    }
    var arrayOfButtonsPressedForTipRateAsString: [String] {
        didSet {
            calcModel.tipRate = processInput(arrayOfButtonsPressedForTipRateAsString, inputStyle: .TwoDecimalPercent)
        }
    }
    var arrayOfButtonsPressedForNumberOfPeoplePayingAsString: [String] {
        didSet {
            calcModel.partySize = Int(processInput(arrayOfButtonsPressedForNumberOfPeoplePayingAsString, inputStyle: .Integer))
        }
    }
    var arrayOfButtonsPressedForLocalSalesTax: [String] {
        didSet {
            UserPreferences.sharedInstance.localSalesTax = processInput(arrayOfButtonsPressedForLocalSalesTax, inputStyle: .ThreeDecimalPercent)
        }
    }
    
    var arrayOfButtonsPressedForPoorTip: [String] {
        didSet {
            userDefinedTipRatings(self.arrayOfButtonsPressedForPoorTip, serviceQuality: .Bad)
        }
    }
    var arrayOfButtonsPressedForAverageTip: [String] {
        didSet {
            userDefinedTipRatings(self.arrayOfButtonsPressedForAverageTip, serviceQuality: .Good)
        }
    }
    var arrayOfButtonsPressedForGreatTip: [String] {
        didSet {
            userDefinedTipRatings(self.arrayOfButtonsPressedForGreatTip, serviceQuality: .Great)
        }
    }
    
    var arrayOfButtonsNewBadTip: [String] {
        didSet {
            VenueCreator.sharedInstance.badServiceTipAmount = processInput(arrayOfButtonsNewBadTip, inputStyle: .TwoDecimalPercent)
        }
    }
    var arrayOfButtonsNewGoodTip: [String] {
        didSet {
            VenueCreator.sharedInstance.goodServiceTipAmount = processInput(arrayOfButtonsNewGoodTip, inputStyle: .TwoDecimalPercent)
        }
    }
    var arrayOfButtonsNewGreatTip: [String] {
        didSet {
            VenueCreator.sharedInstance.greatServiceTipAmount = processInput(arrayOfButtonsNewGreatTip, inputStyle: .TwoDecimalPercent)
        }
    }
    
    private init() {
        if let tipArray = mUserDefaults?.array(forKey: "quickTipArray") {
            tipRateArray = tipArray as! [Double]
        } else {
            tipRateArray = [0.0, 0.0, 0.0]
        }
        
        arrayOfButtonsPressedForBillAmountAsString = []
        arrayOfButtonsPressedForTaxAmountAsString = []
        arrayOfButtonsPressedForTipRateAsString = []
        arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
        arrayOfButtonsPressedForLocalSalesTax = []
        
        arrayOfButtonsPressedForPoorTip = []
        arrayOfButtonsPressedForAverageTip = []
        arrayOfButtonsPressedForGreatTip = []
        
        arrayOfButtonsNewBadTip = []
        arrayOfButtonsNewGoodTip = []
        arrayOfButtonsNewGreatTip = []
    }
    
    var firstResponderTag = 0
    
    /* Functions */
    
    /// Converts the array of string values to the Double they represent
    func processInput(_ arrayOfStringNumericValues: [String], inputStyle: InputStyles) -> Double {
        var inputAmount = 0.0
         
        if !arrayOfStringNumericValues.isEmpty {
            if (arrayOfStringNumericValues.count <= 10) {

                switch inputStyle {
                case .TwoDecimalPercent:
                inputAmount = NumberFormatter().number(from: arrayOfStringNumericValues.joined(separator: "")) as! Double * 0.0001
                case .ThreeDecimalPercent:
                inputAmount = NumberFormatter().number(from: arrayOfStringNumericValues.joined(separator: "")) as! Double * 0.00001
                case .Integer:
                inputAmount = NumberFormatter().number(from: arrayOfStringNumericValues.joined(separator: "")) as! Double
                case .Currency:
                inputAmount = NumberFormatter().number(from: arrayOfStringNumericValues.joined(separator: "")) as! Double * 0.01
                }
            }
        } else {
            if inputStyle == .Integer { inputAmount = 1.0 }
        }
        return inputAmount
    }
    
    func resetValues() {
        calcModel.partySize = 1
        calcModel.totalAmount = 0.00
        calcModel.totalAmountPerPerson = 0.00
        calcModel.tipAmount = 0.0
        calcModel.subtotal = 0.00
        calcModel.tipRate = 0.0
        calcModel.taxAmount = 0.00
        calcModel.selectedVenue = Venues.sharedInstance.selectedVenue
        
        tipRateArray = Venues.sharedInstance.currentTipRates(for: calcModel.selectedVenue)!
        
        arrayOfButtonsPressedForBillAmountAsString = []
        arrayOfButtonsPressedForTaxAmountAsString = []
        arrayOfButtonsPressedForTipRateAsString = []
        arrayOfButtonsPressedForNumberOfPeoplePayingAsString = []
        
        arrayOfButtonsPressedForPoorTip = []
        arrayOfButtonsPressedForAverageTip = []
        arrayOfButtonsPressedForGreatTip = []
        
        arrayOfButtonsNewBadTip = []
        arrayOfButtonsNewGoodTip = []
        arrayOfButtonsNewGreatTip = []
    }
    
}
