//
//  NeumorphicButtons.swift
//  Tippo
//
//  Created by Donovan McCray on 7/3/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct NeumorphicButtons: View {
    var body: some View {
        Button(action: {
            print("Hello")
        }) {
        
            VStack {
                Text("Button")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .frame(width: 200, height: 60)
                    .background(
                        ZStack {
                            Color("DropShadowBlue")
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundColor(.white)
                                .blur(radius: 4)
                                .offset(x: -8, y: -8)
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("DropShadowBlue"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color("DropShadowBlue"), radius: 20, x: 10, y: 10)
                    .shadow(color: Color(.white), radius: 20, x: -10, y: -10)
            }
        }
    }
}

struct NeumorphicRaisedSection: View {
    var body: some View {
        Button(action: {
            print("Hello")
        }) {
            VStack {
                Text("Button")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .frame(width: 200, height: 60)
                    .background(
                        ZStack {
                            Color("Background")
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundColor(Color("DropShadowBlue").opacity(0.20))
                            .blur(radius: 4)
//                            .offset(x: 5, y: 5)
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundColor(Color("Background"))
                                .padding(2)
                                .blur(radius: 2)
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color("Jet").opacity(0.83), radius: 5, x: 5, y: 5)
                    .shadow(color: Color(.white).opacity(0.83), radius: 5, x: -5, y: -5)
            }
        }
    }
}

struct NeumorphicRecessedSection: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(width: 400, height: 300)
        .background(
            ZStack {
                Color("DropShadowBlue").opacity(0.75)

                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color("Licorice"), Color("Background")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .blur(radius: 4)
                    .offset(x: -8, y: -8)

                RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(Color("Background"))
                .padding(2)
                .blur(radius: 2)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct AbstractNeumorphicButton: View {
    var viewBackgroundAccentColor: Color
    var buttonColor: Color
    
    var body: some View {
        Button(action: {
            
        }) {
            VStack {
                Text("Button")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .frame(width: 200, height: 60)
                    .background(
                        ZStack {
                            self.buttonColor
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundColor(self.viewBackgroundAccentColor)
                                .blur(radius: 4)
                                .offset(x: -8, y: -8)
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [self.buttonColor, self.viewBackgroundAccentColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: self.buttonColor, radius: 20, x: 10, y: 10)
                    .shadow(color: self.viewBackgroundAccentColor, radius: 20, x: -10, y: -10)
            }
        }
    }
}

struct NeumorphicStyle: ViewModifier {
    var viewBackgroundAccentColor: Color
    var buttonColor: Color
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(
                ZStack {
                    self.buttonColor
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(self.viewBackgroundAccentColor)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [self.buttonColor, self.viewBackgroundAccentColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .padding(2)
                    .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: self.buttonColor, radius: 20, x: 5, y: 5)
            .shadow(color: self.viewBackgroundAccentColor, radius: 20, x: -5, y: -5)
    }
}

struct NeumorphicButtons_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            NeumorphicButtons()
            NeumorphicButtons()
            AbstractNeumorphicButton(viewBackgroundAccentColor: .white, buttonColor: Color("DropShadowBlue"))
            NeumorphicRaisedSection()
            NeumorphicRecessedSection()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.all)
    }
}
