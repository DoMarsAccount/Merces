//
//  CollapsableSheetView.swift
//  Tippo
//
//  Created by Donovan McCray on 7/1/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI


fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.10
    static let minHeightRatio: CGFloat = 0.4
}

struct CollapsableSheetView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = 0
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(width: Constants.indicatorWidth, height: Constants.indicatorHeight)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geo.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(self.colorScheme == .light ? .systemBackground : .secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geo.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture (
                DragGesture().updating(self.$translation, body: { (value, state, _) in
                    state = value.translation.height
                    print(value.translation.height)
                })
                .onEnded({ (value) in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                })
            )
        }
    }
}

