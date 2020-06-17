//
//  CardViewModifier.swift
//  TipTok
//
//  Created by Donovan McCray on 6/17/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct TTCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .padding()
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    ZStack {
                        Color(.white)
                        
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
//                            .fill(
//                                LinearGradient(gradient: Gradient(colors: [Color("DropShadowBlack"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                            )
                            .foregroundColor(.white)
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color("DropShadowBlack"), radius: 20, x: 0, y: 20)
//                .shadow(color: Color("DropShadowBlack"), radius: 10, x: 0, y: 0)
        }
    }
}

extension View {
    func cardStyled(value: Binding<Double>, backgroundColor: Color = .black) -> some View {
        self.modifier(TTCardModifier())
    }
}

struct CardViewModifier: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CardViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        CardViewModifier()
    }
}
