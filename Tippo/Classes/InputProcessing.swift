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
            if (arrayOfStringNumericValues.count <= 15) {
                let number = NumberFormatter().number(from: arrayOfStringNumericValues.joined(separator: "")) as! Double
                switch inputStyle {
                case .TwoDecimalPercent:
                inputAmount = number * 0.0001
                case .ThreeDecimalPercent:
                inputAmount = number * 0.00001
                case .Integer:
                inputAmount = number
                case .Currency:
                inputAmount = number * 0.01
                }
            } else {
                let number: Double = 999999999999999
                switch inputStyle {
                case .TwoDecimalPercent:
                inputAmount = number * 0.0001
                case .ThreeDecimalPercent:
                inputAmount = number * 0.00001
                case .Integer:
                inputAmount = number
                case .Currency:
                inputAmount = number * 0.01
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
    
    func convertToStringArray(input: Double) -> [String] {
        var stringEquivalentArray: [String] = []
        for num in input.description {
            if num != "." { stringEquivalentArray.append("\(num)") }
        }
        return stringEquivalentArray
    }
    // MARK: Round to 2 decimal places in the conversion
    func convertToDouble(input: [String], inputStyle: InputStyles) -> Double {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        let number = formatter.number(from: input.joined(separator: "")) as! Double
        switch inputStyle {
        case .TwoDecimalPercent:
        return formatter.number(from: input.joined(separator: "")) as! Double * 0.0001
        case .ThreeDecimalPercent:
        return formatter.number(from: input.joined(separator: "")) as! Double * 0.00001
        case .Integer:
        return formatter.number(from: input.joined(separator: "")) as! Double
        case .Currency:
        return formatter.number(from: input.joined(separator: "")) as! Double * 0.01
        }
    }
    
    func add(newDigit: String) {
        switch self.activeField {
        case .subtotal:
            var newVal = convertToStringArray(input: calcModel.subtotal)
            newVal.append(newDigit)
//            print(newVal)
            calcModel.subtotal = convertToDouble(input: newVal, inputStyle: .Currency)
            print(calcModel.subtotal)
        case .salesTax:
            var newVal = convertToStringArray(input: calcModel.taxAmount)
            newVal.append(newDigit)
            calcModel.taxAmount = convertToDouble(input: newVal, inputStyle: .Currency)
        case .partySize:
            var newVal = convertToStringArray(input: calcModel.partySize.double)
            newVal.append(newDigit)
            calcModel.partySize = Int(convertToDouble(input: newVal, inputStyle: .Integer))
        case .tipRate:
            var newVal = convertToStringArray(input: calcModel.tipRate)
            newVal.append(newDigit)
            calcModel.tipRate = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
        case .localTax:
            var newVal = convertToStringArray(input: UserPreferences.sharedInstance.localSalesTax)
            newVal.append(newDigit)
            UserPreferences.sharedInstance.localSalesTax = convertToDouble(input: newVal, inputStyle: .ThreeDecimalPercent)
        case .badTip:
            var newVal = convertToStringArray(input: VenueEditor.sharedInstance.badServiceTipAmount)
            newVal.append(newDigit)
            VenueEditor.sharedInstance.badServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
        case .goodTip:
            var newVal = convertToStringArray(input: VenueEditor.sharedInstance.goodServiceTipAmount)
            newVal.append(newDigit)
            VenueEditor.sharedInstance.goodServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
        case .greatTip:
            var newVal = convertToStringArray(input: VenueEditor.sharedInstance.greatServiceTipAmount)
            newVal.append(newDigit)
            VenueEditor.sharedInstance.greatServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
        case .newBadTip:
            var newVal = convertToStringArray(input: VenueCreator.sharedInstance.badServiceTipAmount)
            newVal.append(newDigit)
            VenueCreator.sharedInstance.badServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
        case .newGoodTip:
            var newVal = convertToStringArray(input: VenueCreator.sharedInstance.goodServiceTipAmount)
            newVal.append(newDigit)
            VenueCreator.sharedInstance.goodServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
        case .newGreatTip:
            var newVal = convertToStringArray(input: VenueCreator.sharedInstance.greatServiceTipAmount)
            newVal.append(newDigit)
            VenueCreator.sharedInstance.greatServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
        default:
            break
        }
    }
    
    func delete() {
        switch self.activeField {
        case .subtotal:
            if !convertToStringArray(input: calcModel.subtotal).isEmpty {
                var newVal = convertToStringArray(input: calcModel.subtotal)
                newVal.removeLast(1)
                calcModel.subtotal = convertToDouble(input: newVal, inputStyle: .Currency)
            }
        case .salesTax:
            if !convertToStringArray(input: calcModel.taxAmount).isEmpty {
                var newVal = convertToStringArray(input: calcModel.taxAmount)
                newVal.removeLast(1)
                calcModel.taxAmount = convertToDouble(input: newVal, inputStyle: .Currency)
            }
        case .partySize:
            if !convertToStringArray(input: calcModel.partySize.double).isEmpty {
                var newVal = convertToStringArray(input: calcModel.partySize.double)
                newVal.removeLast(1)
                calcModel.partySize = Int(convertToDouble(input: newVal, inputStyle: .Integer))
            }
        case .tipRate:
            if !convertToStringArray(input: calcModel.tipRate).isEmpty {
                var newVal = convertToStringArray(input: calcModel.tipRate)
                newVal.removeLast(1)
                calcModel.tipRate = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
            }
        case .localTax:
            if !convertToStringArray(input: UserPreferences.sharedInstance.localSalesTax).isEmpty {
                var newVal = convertToStringArray(input: UserPreferences.sharedInstance.localSalesTax)
                newVal.removeLast(1)
                UserPreferences.sharedInstance.localSalesTax = convertToDouble(input: newVal, inputStyle: .ThreeDecimalPercent)
            }
        case .badTip:
            if !convertToStringArray(input: VenueEditor.sharedInstance.badServiceTipAmount).isEmpty {
                var newVal = convertToStringArray(input: VenueEditor.sharedInstance.badServiceTipAmount)
                newVal.removeLast(1)
                VenueEditor.sharedInstance.badServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
            }
        case .goodTip:
            if !convertToStringArray(input: VenueEditor.sharedInstance.goodServiceTipAmount).isEmpty {
                var newVal = convertToStringArray(input: VenueEditor.sharedInstance.goodServiceTipAmount)
                newVal.removeLast(1)
                VenueEditor.sharedInstance.goodServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
            }
        case .greatTip:
            if !convertToStringArray(input: VenueEditor.sharedInstance.greatServiceTipAmount).isEmpty {
                var newVal = convertToStringArray(input: VenueEditor.sharedInstance.greatServiceTipAmount)
                newVal.removeLast(1)
                VenueEditor.sharedInstance.greatServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
            }
        case .newBadTip:
            if !convertToStringArray(input: VenueCreator.sharedInstance.badServiceTipAmount).isEmpty {
                var newVal = convertToStringArray(input: VenueCreator.sharedInstance.badServiceTipAmount)
                newVal.removeLast(1)
                VenueCreator.sharedInstance.badServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
            }
        case .newGoodTip:
            if !convertToStringArray(input: VenueCreator.sharedInstance.goodServiceTipAmount).isEmpty {
                var newVal = convertToStringArray(input: VenueCreator.sharedInstance.goodServiceTipAmount)
                newVal.removeLast(1)
                VenueCreator.sharedInstance.goodServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
            }
        case .newGreatTip:
            if !convertToStringArray(input: VenueCreator.sharedInstance.greatServiceTipAmount).isEmpty {
                var newVal = convertToStringArray(input: VenueCreator.sharedInstance.greatServiceTipAmount)
                newVal.removeLast(1)
                VenueCreator.sharedInstance.greatServiceTipAmount = convertToDouble(input: newVal, inputStyle: .TwoDecimalPercent)
            }
        default:
            break
        }
    }
    
}
