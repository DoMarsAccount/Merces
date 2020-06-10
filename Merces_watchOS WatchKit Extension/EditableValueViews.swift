//
//  EditableValueViews.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

// MARK: - Keypad.swift
struct KeypadEditableIntegerValueView: View {
    @Binding var title: String
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text("\(self.title) \(Int(self.value))")
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct KeypadEditableCurrencyValueView: View {
    @Binding var title: String
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text("\(self.title) \(nForm.roundForCurrency(number: self.value))")
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct KeypadEditablePercentageValueView: View {
    @Binding var title: String
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text("\(self.title) \(nForm.roundForPercentWithTwoDecimalPlaces(self.value))")
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

// MARK: - Digital Crown

struct dCrownEditableIntegerValueView: View {
    @Binding var title: String
    @Binding var value: Double
    @State private var isFocused: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text("\(self.title) \(Int(self.value))")
                    .focusable(true, onFocusChange: { (didChange) in
                        self.isFocused = didChange
                    })
                    .digitalCrownRotation(self.$value, from: 1.0, through: 100.0, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(self.isFocused ? Color.green : Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct dCrownEditableCurrencyValueView: View {
    @Binding var title: String
    @Binding var value: Double
    @State private var isFocused: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text("\(self.title) \(nForm.roundForCurrency(number: self.value))")
                    .focusable(true, onFocusChange: { (didChange) in
                        self.isFocused = didChange
                    })
                    .digitalCrownRotation(self.$value, from: 0.0, through: 101.0, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(self.isFocused ? Color.green : Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct dCrownEditablePercentageValueView: View {
    @Binding var title: String
    @Binding var value: Double
    @State private var isFocused: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text("\(self.title) \(nForm.roundForPercentWithTwoDecimalPlaces(self.value))")
                    .focusable(true, onFocusChange: { (didChange) in
                        self.isFocused = didChange
                    })
                    .digitalCrownRotation(self.$value, from: 0.0, through: 1.000, by: 0.01, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(self.isFocused ? Color.green : Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}
// MARK: - Previews
struct EditableValueViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            dCrownEditableIntegerValueView(title: .constant("Party of"), value: .constant(1))
        }
    }
}
