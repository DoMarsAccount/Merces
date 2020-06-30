//
//  ThemesPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/21/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI
import ChameleonFramework

struct ColorSelectionItem: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    var themeItem: ThemeItem
    var color: UIColor
    var body: some View {
        Button(action: {
            switch self.themeItem {
            case .MainColor:
                if self.themes.appearance == .Light { self.themes.mainColor = self.color }
                else { self.themes.mainColorDark = self.color }
            case .Background:
                if self.themes.appearance == .Light { self.themes.background = self.color }
                else { self.themes.backgroundColorDark = self.color }
            case .ViewColor:
                if self.themes.appearance == .Light { self.themes.viewColor = self.color }
                else { self.themes.viewColorDark = self.color }
            }
        }) {
            ZStack {
                Circle()
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark, isFlat: true)))
                
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
    var body: some View {
        ZStack {
            Color(self.colorScheme == .dark ? self.themes.backgroundColorDark : self.themes.background)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ListInputRow(value: .constant(123.45), inputStyle: .Currency, title: "Example", field: .none, background: self.themes.appearance == .Light ? self.themes.mainColor : self.themes.mainColorDark)
                
                AppearancePicker(appearance: self.$themes.appearance)
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
    @Environment(\.colorScheme) var colorScheme
    var themeItem: ThemeItem
    var body: some View {
        VStack(spacing: 0) {
            
            if self.themeItem == .MainColor {
                Text("Inputs Color: \(Coloring().TTColorRepresentation(for: self.themes.appearance == Appearance.Light ? self.themes.mainColor : self.themes.mainColorDark).name)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 24))
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.appearance == .Light ? self.themes.mainColor : self.themes.mainColorDark, isFlat: true)))
                    .background(Color(self.themes.appearance == .Light ? self.themes.mainColor : self.themes.mainColorDark))
                    .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
                
            } else if self.themeItem == .Background {
                Text("App Background Color: \(Coloring().TTColorRepresentation(for: self.themes.appearance == Appearance.Light ? self.themes.background : self.themes.backgroundColorDark).name)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20))
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.appearance == .Light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
                    .background(Color(self.themes.appearance == .Light ? self.themes.background : self.themes.backgroundColorDark))
                    .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
                
            } else if self.themeItem == .ViewColor {
                Text("Outputs Color: \(Coloring().TTColorRepresentation(for: self.themes.appearance == Appearance.Light ? self.themes.viewColor : self.themes.viewColorDark).name)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 24))
                    .foregroundColor(Color(UIColor(contrastingBlackOrWhiteColorOn: self.themes.appearance == .Light ? self.themes.viewColor : self.themes.viewColorDark, isFlat: true)))
                    .background(Color(self.themes.appearance == .Light ? self.themes.viewColor : self.themes.viewColorDark))
                    .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
                
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<MercesColors.allCases.count) { index in
                        ColorSelectionItem(themeItem: self.themeItem, color: MercesColors.allCases[index].color)
                    }
                }.padding()
            }.background(Color(self.colorScheme == .light ? self.themes.viewColor : self.themes.viewColorDark))
            
        }
        .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? self.themes.background : self.themes.backgroundColorDark, isFlat: true)))
    }
}
