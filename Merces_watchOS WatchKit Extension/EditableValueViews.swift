//
//  EditableValueViews.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/8/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct EditableIntegerValueView: View {
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
                    .digitalCrownRotation(self.$value, from: 0.0, through: 101.0, by: 1.0, sensitivity: .medium, isContinuous: true, isHapticFeedbackEnabled: true)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(self.isFocused ? Color.green : Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct EditableCurrencyValueView: View {
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
                    .digitalCrownRotation(self.$value, from: 0.0, through: 101.0, by: 1.0, sensitivity: .medium, isContinuous: true, isHapticFeedbackEnabled: true)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(self.isFocused ? Color.green : Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct EditablePercentageValueView: View {
    @Binding var title: String
    @Binding var value: Double
    @State private var isFocused: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text("\(self.title) \(nForm.roundForPercentWithTwoDecimalPlaces(self.value * 0.01))")
                    .focusable(true, onFocusChange: { (didChange) in
                        self.isFocused = didChange
                    })
                    .digitalCrownRotation(self.$value, from: 0.0, through: 100.01, by: 1.0, sensitivity: .medium, isContinuous: true, isHapticFeedbackEnabled: true)
            }
            .padding([.leading, .trailing])
            .frame(width: geo.size.width)
            .border(self.isFocused ? Color.green : Color.gray, width: 2.5)
            .cornerRadius(2.5)
        }
    }
}

struct EditableValueViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EditableIntegerValueView(title: .constant("Party of"), value: .constant(1))
        }
    }
}
