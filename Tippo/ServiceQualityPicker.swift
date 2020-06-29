//
//  ServiceQualityPicker.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ServiceQualityPicker: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes = Themes.sharedInstance
    @ObservedObject var calcModel = CalculationsModel.sharedInstance
    
    var body: some View {
        Picker(selection: self.$calcModel.service, label: Text("Service Quality")) {
            ForEach(0..<ServiceQuality.allCases.count) { index in
                ServiceQuality.allCases[index].image
                    .resizable()
                    .tag(ServiceQuality.allCases[index])
                    .accessibility(label: Text("Service Quality: \(ServiceQuality.allCases[index].name)"))
                    .accentColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isFlat: true)))
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isFlat: true)))
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .scaledToFill()
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .circular))
        .accessibility(label: Text("Service Quality: \(self.calcModel.service.name)"))
    }
}

struct ServiceQualityPicker_Previews: PreviewProvider {
    static var previews: some View {
        ServiceQualityPicker()
    }
}
