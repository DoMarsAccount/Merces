//
//  CardViewModifier.swift
//  TipTok
//
//  Created by Donovan McCray on 6/17/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct MercesStyleCard: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .padding()
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .foregroundColor(self.colorScheme == .dark ? Color("Eerie") : .white)
                )
                .border(Color.primary, width: 2)
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        }
    }
}

struct TTCardModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .padding()
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    ZStack {
//                        Color(.white)
                        
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(self.colorScheme == .dark ? .secondary : .secondary)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(self.colorScheme == .dark ? Color("Eerie") : Color("Snow"))
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: self.colorScheme == .dark ? .black :  Color("OuterSpace"), radius: 10)
        }
    }
}

extension View {
    func cardStyled(value: Binding<Double>, backgroundColor: Color = .black) -> some View {
        self.modifier(TTCardModifier())
    }
}
