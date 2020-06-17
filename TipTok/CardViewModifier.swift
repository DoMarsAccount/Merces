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
//                .border(Color.primary, width: 1)
                .background(
                    ZStack {
                        Color(.white)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("Background"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color("DropShadow"), radius: 20, x: 20, y: 20)
                .shadow(color: .white, radius: 20, x: -20, y: -20)
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
