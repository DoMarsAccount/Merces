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

struct ColorSelectionItem: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isActive: Bool = false
    var color: UIColor
    var body: some View {
        Button(action: {
            themes.setMainColor(to: self.color)
        }) {
            ZStack {
                Circle()
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Circle()
                    .foregroundColor(.green)
                    .opacity(isActive ? 1.0 : 0.0)
                
                Circle()
                    .padding(4)
                    .foregroundColor(Color(color))
            }
            .frame(width: 80, height: 80)
        }
        
    }
}

struct ThemesPage: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var appearance: Appearance = .Light
    var body: some View {
        ZStack {
            Color(self.colorScheme == .dark ? .black : themes.background)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                AppearancePicker(appearance: $appearance)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<TipTokColor.allCases.count) { index in
                            ColorSelectionItem(color: TipTokColor.allCases[index].color)
                        }
                    }
                }.background(Color.white)
                
                Text("Main Color: \(TipTokColor.MercesGreen.name)")
                    .padding()
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: themes.mainColor, isFlat: true)))
                    .background(Color(themes.mainColor))
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
