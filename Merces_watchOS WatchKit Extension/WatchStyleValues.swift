//
//  WatchStyleValues.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/13/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

let title3TextSize: CGFloat = 19
let headlineTextSize: CGFloat = 16
let subHeadlineTextSize: CGFloat = 16

/// This is a general Text View that utilizes Dynamic Type to switch between the Merces font and the System font
struct MercesText: View {
    @Binding var text: String
    var body: some View {
        Text(self.text)
            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: subHeadlineTextSize)))
        
    }
}
