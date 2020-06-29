//
//  Themes.swift
//  TipTok
//
//  Created by Donovan McCray on 6/26/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

enum ThemeItem {
    case MainColor
    case Background
    case ViewColor
}

enum Appearance: CaseIterable, Hashable, Identifiable {
    case Light
    case Dark
    
    var name: String {
        return "\(self)"
    }
    var id: Appearance { self }
}

class Themes: ObservableObject {
    static let sharedInstance: Themes = Themes()
    private let coloring = Coloring()
    @Environment(\.colorScheme) var colorScheme
    @Published var appearance: Appearance = .Light
    @Published var shouldReloadTheme: Bool = true
    @Published var mainColor: UIColor {
        didSet {
            mUserDefaults!.setValue("\(mainColor)", forKey: "phoneMainColor")
            shouldReloadTheme = true
        }
    }
    @Published var background: UIColor {
        didSet {
            mUserDefaults!.setValue("\(background)", forKey: "phoneBackgroundColor")
            shouldReloadTheme = true
        }
    }
    @Published var viewColor: UIColor {
        didSet {
            mUserDefaults!.setValue("\(viewColor)", forKey: "phoneViewBackgroundColor")
            shouldReloadTheme = true
        }
    }
    @Published var mainColorDark: UIColor {
        didSet {
            mUserDefaults!.setColor(color: mainColorDark, forKey: "mainColorDark")
            shouldReloadTheme = true
        }
    }
    @Published var backgroundColorDark: UIColor {
        didSet {
            mUserDefaults!.setColor(color: backgroundColorDark, forKey: "backgroundColorDark")
            shouldReloadTheme = true
        }
    }
    @Published var viewColorDark: UIColor {
        didSet {
            mUserDefaults!.setColor(color: viewColorDark, forKey: "viewColorDark")
            shouldReloadTheme = true
        }
    }
    
    init() {
        // MARK: Light Mode colors
        if let currentMainColor = mUserDefaults?.string(forKey: "phoneMainColor") {
            mainColor = coloring.uiColor(for: currentMainColor)
        } else {
            mainColor = coloring.uiColorValue(for: .MercesGreen)
        }
        
        if let currentBackgroundColor = mUserDefaults?.string(forKey: "phoneBackgroundColor") {
            background = coloring.uiColor(for: currentBackgroundColor)
        } else {
            background = coloring.uiColorValue(for: .LightGray)
        }
        
        if let currentViewBackgroundColor = mUserDefaults?.string(forKey: "phoneViewBackgroundColor") {
            viewColor = coloring.uiColor(for: currentViewBackgroundColor)
        } else {
            viewColor = coloring.uiColorValue(for: .White)
        }
        
        if let currMainColorDark = mUserDefaults?.colorForKey(key: "mainColorDark") {
            mainColorDark = currMainColorDark
        } else {
            mainColorDark = .black
        }
        
        // MARK: Dark Mode colors
        if let currBackgroundColorDark = mUserDefaults?.colorForKey(key: "backgroundColorDark") {
            backgroundColorDark = currBackgroundColorDark
        } else {
            backgroundColorDark = .black
        }
        
        if let currViewColorDark = mUserDefaults?.colorForKey(key: "viewColorDark") {
            viewColorDark = currViewColorDark
        } else {
            viewColorDark = .black
        }
        
    }
    
    func isActiveColor(uicolor: UIColor, for themeItem: ThemeItem) -> Bool {
        if self.appearance == .Light {
            switch themeItem {
            case .MainColor:
                return uicolor == self.mainColor
            case .Background:
                return uicolor == self.background
            case .ViewColor:
                return uicolor == self.viewColor
            }
        } else {
            switch themeItem {
            case .MainColor:
                return uicolor == self.mainColorDark
            case .Background:
                return uicolor == self.backgroundColorDark
            case .ViewColor:
                return uicolor == self.viewColorDark
            }
        }
    }
    
    func reset() {
        if self.appearance == .Light {
            self.mainColor = coloring.uiColorValue(for: .MercesGreen)
            self.background = coloring.uiColorValue(for: .LightGray)
            self.viewColor = coloring.uiColorValue(for: .White)
        } else {
            self.mainColor = coloring.uiColorValue(for: .Black)
            self.background = coloring.uiColorValue(for: .Black)
            self.viewColor = coloring.uiColorValue(for: .Black)
        }
    }
    
}
