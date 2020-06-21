//
//  ThemesPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/21/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

enum Appearance: CaseIterable, Hashable, Identifiable {
    case Light
    case Dark
    
    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }
    
    var id: Appearance { self }
}

struct ThemesPage: View {
    @State private var appearance: Appearance = .Light
    var body: some View {
        
        Picker(selection: self.$appearance, label: Text("Appearance")) {
            ForEach(0..<Appearance.allCases.count) { index in
                Text(Appearance.allCases[index].name)
                    .tag(Appearance.allCases[index])
                    .accessibility(value: Text("Appearance: \(Appearance.allCases[index].name)"))
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .circular))
    }
}

struct ThemesPage_Previews: PreviewProvider {
    static var previews: some View {
        ThemesPage()
    }
}
