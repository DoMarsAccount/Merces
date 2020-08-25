//
//  NeumorphicTesting.swift
//  Tippo
//
//  Created by Donovan McCray on 7/3/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

fileprivate enum colors {
    static let background: Color = Color(#colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1))
    static let border = Color(.white).opacity(0.20)
    static let lightShadow = Color(.white).opacity(0.83)
    static let darkShadow = Color(#colorLiteral(red: 0.8509803922, green: 0.8235294118, blue: 0.7843137255, alpha: 0.51))
    static let innerLight = Color(.white)
    static let innerDark = Color(#colorLiteral(red: 0.8431372549, green: 0.8392156863, blue: 0.8392156863, alpha: 1))
}

struct NeumorphicTesting: View {
    var body: some View {
        VStack(spacing: 20) {
            FlatNeumorphicButton()
            RecessedNeumorphicButton()
            ConcaveNeumorphicButton()
            ConvexNeumorphicButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colors.background)
        .edgesIgnoringSafeArea(.all)
    }
}

struct NeumorphicTesting_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphicTesting()
    }
}

struct FlatNeumorphicButton: View {
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        colors.background
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(colors.border)
                            .blur(radius: 4)
                        //                                .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(colors.background)
                            .padding(2)
                            .blur(radius: 2)
                    }
            )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: colors.darkShadow, radius: 6, x: 6, y: 6)
                .shadow(color: colors.lightShadow, radius: 6, x: -6, y: -6)
        }
    }
}

struct RecessedNeumorphicButton: View {
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        colors.darkShadow
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("Licorice"), colors.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(colors.background)
                            .padding(1)
                            .blur(radius: 2)
                    }
            )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

struct ConcaveNeumorphicButton: View {
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        colors.background
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(colors.border)
                            .blur(radius: 4)
//                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
//                                LinearGradient(gradient: Gradient(colors: [colors.darkShadow, colors.lightShadow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                
                                RadialGradient(gradient: Gradient(colors: [colors.darkShadow, colors.innerLight]), center: .topLeading, startRadius: 0, endRadius: 200)
                        )
                            .blur(radius: 2)
                    }
            )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: colors.darkShadow, radius: 6, x: 6, y: 6)
                .shadow(color: colors.lightShadow, radius: 6, x: -6, y: -6)
        }
    }
}

struct ConvexNeumorphicButton: View {
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        colors.background
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(colors.border)
                            .blur(radius: 4)
                        //                                .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                //                                    LinearGradient(gradient: Gradient(colors: [colors.background, colors.darkShadow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                
                                //                                    AngularGradient(gradient: Gradient(colors: [colors.background, colors.darkShadow]), center: .center, angle: .degrees(135))
                                
                                RadialGradient(gradient: Gradient(colors: [colors.innerLight, colors.darkShadow]), center: .topLeading, startRadius: 0, endRadius: 350)
                        )
                            .blur(radius: 2)
                    }
            )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: colors.darkShadow, radius: 6, x: 6, y: 6)
                .shadow(color: colors.lightShadow, radius: 6, x: -6, y: -6)
        }
    }
}
