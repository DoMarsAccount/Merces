//
//  ThemesPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/21/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI
import ChameleonFramework

enum Appearance: CaseIterable, Hashable, Identifiable {
    case Light
    case Dark
    
    var name: String {
        return "\(self)"
    }
    var id: Appearance { self }
}

struct ThemesPage: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var appearance: Appearance = .Light
    var body: some View {
        ZStack {
            Color(self.colorScheme == .dark ? .black : coloringThemes.backgroundColor)
                .edgesIgnoringSafeArea(.bottom)
            
            VStack {
                AppearancePicker(appearance: $appearance)
                
                Text("Main Color: \(TipTokColor.MercesGreen.name)")
                    .padding()
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.mainColor, isFlat: true)))
                    .background(Color(coloringThemes.mainColor))
            }
            .padding()
        }
    }
}

struct ThemesPage_Previews: PreviewProvider {
    static var previews: some View {
        ThemesPage()
    }
}

struct AppearancePicker: View {
    @Binding var appearance: Appearance
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
