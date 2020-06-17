//
//  ServiceQualityPicker.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ServiceQualityPicker: View {
    @ObservedObject var calcModel = varAmts.calcModel
    
    var body: some View {
        GeometryReader { geo in
            Picker(selection: self.$calcModel.service, label: Text("Service Quality")) {
                ForEach(0..<ServiceQuality.allCases.count) { index in
                    ServiceQuality.allCases[index].image
                        .tag(ServiceQuality.allCases[index])
                        .accessibility(value: Text("Service Level: \(ServiceQuality.allCases[index].name)"))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .clipShape(RoundedRectangle(cornerRadius: 2, style: .circular))
//            .border(Color.primary, width: 2)
//            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct ServiceQualityPicker_Previews: PreviewProvider {
    static var previews: some View {
        ServiceQualityPicker()
    }
}
