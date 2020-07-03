//
//  CardViewModifier.swift
//  TipTok
//
//  Created by Donovan McCray on 6/17/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct AdaptiveCardBackground: ViewModifier {
    @ObservedObject var userPrefs: UserPreferences = UserPreferences.sharedInstance
    var backgroundColor: UIColor
    var usePadding: Bool = true
    var isInputCard: Bool = true
    
    func body(content: Content) -> some View {
        Group {
            if userPrefs.useFlatStyleViews {
                content.modifier(FlatCard(usePadding: self.usePadding, backgroundColor: self.backgroundColor, isInputCard: self.isInputCard))
            } else {
                content.modifier(TipTokStyleCard(usePadding: self.usePadding, backgroundColor: Color(self.backgroundColor)))
            }
        }
    }
}

struct FlatCard: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themes: Themes = Themes.sharedInstance
    var usePadding: Bool = true
    var backgroundColor: UIColor
    var isInputCard: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .padding(self.usePadding ? 16: 0)
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    ZStack {
                        Color(self.isInputCard ? .clear : self.backgroundColor)
                        
                        RoundedRectangle(cornerRadius: self.isInputCard ? 8 : 2.5, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(self.backgroundColor), Color(self.backgroundColor).opacity(0.80)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    }
                )
                .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.colorScheme == .light ? .systemBackground : .secondarySystemBackground, isFlat: true)), width: self.isInputCard ? 0 : 1)
                .clipShape(RoundedRectangle(cornerRadius: self.isInputCard ? 8 : 2.5, style: .continuous))
        }
    }
}

struct TipTokStyleCard: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var usePadding: Bool = true
    var backgroundColor: Color

    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .padding(self.usePadding ? 16: 0)
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8, style: .circular)
                            .foregroundColor(self.colorScheme == .dark ? Color("Eerie") :  Color("Eerie"))
                            .blur(radius: 4)
//                            .offset(x: -8, y: -8)
                        
//                        RoundedRectangle(cornerRadius: 16, style: .continuous)
//                            .foregroundColor(self.colorScheme == .dark ? Color("Eerie") : self.backgroundColor)
//                            .padding(2)
//                            .blur(radius: 2)
                        
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [self.backgroundColor, self.backgroundColor.opacity(0.80)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .shadow(color: self.colorScheme == .dark ? Color("Jet") :  Color("Jet"), radius: 10)
        }
    }
}

extension View {
    func cardStyled(value: Binding<Double>, backgroundColor: Color = .black) -> some View {
        self.modifier(TipTokStyleCard(backgroundColor: Color(Themes.sharedInstance.mainColor)))
    }
}
