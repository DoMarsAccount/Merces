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
    
    func body(content: Content) -> some View {
        Group {
            if userPrefs.useFlatStyleViews {
                content.modifier(MercesStyleCard(usePadding: self.usePadding, backgroundColor: self.backgroundColor))
            } else {
                content.modifier(TipTokStyleCard(usePadding: self.usePadding, backgroundColor: Color(self.backgroundColor)))
            }
        }
    }
}

struct MercesStyleCard: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var usePadding: Bool = true
    var backgroundColor: UIColor
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .padding(self.usePadding ? 16: 0)
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    RoundedRectangle(cornerRadius: 2.5, style: .continuous)
                        .foregroundColor(Color(self.backgroundColor))
                )
                .border(Color(UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true)), width: 1)
                .clipShape(RoundedRectangle(cornerRadius: 2.5, style: .continuous))
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
                        
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(self.colorScheme == .dark ? Color("Charcoal") :  Color("Eerie"))
                            .blur(radius: 4)
//                            .offset(x: -8, y: -8)
                        
//                        RoundedRectangle(cornerRadius: 16, style: .continuous)
//                            .foregroundColor(self.colorScheme == .dark ? Color("Eerie") : self.backgroundColor)
//                            .padding(2)
//                            .blur(radius: 2)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [self.backgroundColor, self.backgroundColor.opacity(0.80)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: self.colorScheme == .dark ? Color("Charcoal") :  Color("Jet"), radius: 10)
        }
    }
}

extension View {
    func cardStyled(value: Binding<Double>, backgroundColor: Color = .black) -> some View {
        self.modifier(TipTokStyleCard(backgroundColor: Color(Themes.sharedInstance.mainColor)))
    }
}
