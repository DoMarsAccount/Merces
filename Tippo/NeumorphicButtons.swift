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
                            Color(#colorLiteral(red: 0.7725490196, green: 0.8156862745, blue: 0.9254901961, alpha: 1))
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundColor(.white)
                                .blur(radius: 4)
                                .offset(x: -8, y: -8)
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7725490196, green: 0.8156862745, blue: 0.9254901961, alpha: 1)), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.7725490196, green: 0.8156862745, blue: 0.9254901961, alpha: 1)), radius: 20, x: 10, y: 10)
                    .shadow(color: Color(.white), radius: 20, x: -10, y: -10)
            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.8941176471, green: 0.9294117647, blue: 1, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct NeumorphicButtons_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NeumorphicButtons()
            NeumorphicButtons()
            NeumorphicButtons()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8941176471, green: 0.9294117647, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    }
}
