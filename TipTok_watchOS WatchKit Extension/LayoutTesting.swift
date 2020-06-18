//
//  LayoutTesting.swift
//  TipTok_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/18/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct EffectTesting: View {
    var backgroundColor: Color = Color("CrayolaRed")
    var value: CGFloat
    var body: some View {
        HStack {
            Text("\(value)")
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: viewHeight)
        .frame(maxWidth: .infinity)
        .background(self.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
    }
}

extension CGFloat {
    var scaled: CGFloat {
        if self > 0.03 {
            return 1
        } else {
            return 0.96 + self
        }
    }
}

struct LayoutTesting: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(1..<6) { _ in
                    GeometryReader { geo in
                        EffectTesting(value: 1 - ((geo.frame(in: .global).maxY)/200))
                        .scaleEffect(
                            (1 - ((geo.frame(in: .global).maxY)/200)).scaled
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: viewHeight)
                }
            }
        }
    }
}

struct LayoutTesting_Previews: PreviewProvider {
    static var previews: some View {
        LayoutTesting()
    }
}
