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
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var themeItem: ThemeItem
    var color: UIColor
    var body: some View {
        Button(action: {
            switch self.themeItem {
            case .MainColor:
                self.themes.mainColor = self.color
            case .Background:
                self.themes.background = self.color
            case .ViewColor:
                self.themes.viewColor = self.color
            }
        }) {
            ZStack {
                Circle()
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Circle()
                    .foregroundColor(.green)
                    .opacity(self.themes.isActiveColor(uicolor: self.color, for: self.themeItem) ? 1.0 : 0.0)
                
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
    @ObservedObject var themes: Themes = Themes.sharedInstance
    @State private var appearance: Appearance = .Light
    var body: some View {
        ZStack {
            Color(self.colorScheme == .dark ? .black : self.themes.background)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ListInputRow(activeField: .constant(.none), value: .constant(123.45), inputStyle: .Currency, title: "Example", field: .none, background: Themes.sharedInstance.mainColor)
                
                AppearancePicker(appearance: $appearance)
                ThemeItemColorPicker(themeItem: .MainColor)
                ThemeItemColorPicker(themeItem: .ViewColor)
                ThemeItemColorPicker(themeItem: .Background)
            }
            .padding()
        }
        .navigationBarTitle(Text("Themes"))
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

struct ThemeItemColorPicker: View {
    @ObservedObject var themes: Themes = Themes.sharedInstance
    var themeItem: ThemeItem
    var body: some View {
        VStack(spacing: 0) {
            
            if self.themeItem == .MainColor {
                Text("Main Color: \(Coloring().TTColorRepresentation(for: self.themes.mainColor).name)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 24))
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.mainColor, isFlat: true)))
                    .background(Color(self.themes.mainColor))
                    .border(Color.primary)
                
            } else if self.themeItem == .Background {
                Text("App Background Color: \(Coloring().TTColorRepresentation(for: self.themes.background).name)")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.system(size: 20))
                .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.background, isFlat: true)))
                .background(Color(self.themes.background))
                .border(Color.primary)
                
            } else if self.themeItem == .ViewColor {
                Text("View Color: \(Coloring().TTColorRepresentation(for: self.themes.viewColor).name)")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.system(size: 24))
                .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.viewColor, isFlat: true)))
                .background(Color(self.themes.viewColor))
                .border(Color.primary)
                
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<TipTokColor.allCases.count) { index in
                        ColorSelectionItem(themeItem: self.themeItem, color: TipTokColor.allCases[index].color)
                    }
                }.padding()
            }.background(Color(self.themes.viewColor))
            
        }.border(Color.primary)
    }
}
