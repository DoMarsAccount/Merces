//
//  MainPageSheet.swift
//  Tippo
//
//  Created by Donovan McCray on 7/2/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

// iPhone SE ratio = 0.4397217929 (284.5 / 647)
// iPhone 11 Pro Max = 0.4523227384 (370 / 818)
// iPhone 11 Pro =  0.446866485 (328 / 734)
// iPhone 11 = 0.4523227384 (370 / 818)

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 18
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.10
    static let minHeightRatio: CGFloat = 0.42
}

struct MainPageSheet: View {
    @Environment(\.colorScheme) var colorScheme
    @GestureState private var translation: CGFloat = 0
    @State private var isOpen: Bool = true
    @State private var isSettingsActive: Bool = false
    
    @EnvironmentObject var userPrefs: UserPreferences
    @ObservedObject var inputs = InputProcessing.sharedInstance
    @ObservedObject var calcModel: CalculationsModel = CalculationsModel.sharedInstance
    @ObservedObject var themes: Themes = Themes.sharedInstance
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    private var indicator: some View {
        Image(systemName: self.isOpen ? "chevron.compact.down" : "chevron.compact.up")
            .resizable()
            .frame(width: Constants.indicatorWidth, height: Constants.indicatorHeight)
            .accentColor(.secondary)
    }
    
    init(maxHeight: CGFloat) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                self.indicator
                    .padding()
                    .onTapGesture {
                        self.isOpen.toggle()
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                
                    VStack {
                        ListInputRow(value: self.$calcModel.subtotal, inputStyle: .Currency, title: "Subtotal", field: .subtotal, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                            .id("\(self.calcModel.subtotal)")
                            .opacity(1.0 - Double((self.offset + self.translation) * 0.0025))
                        
                        if !self.userPrefs.subtotalIsPostTax {
                            ListInputRow(value: self.$calcModel.taxAmount, inputStyle: .Currency, title: "Sales Tax", field: .salesTax, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                                .id("\(self.calcModel.taxAmount)")
                                .opacity(1.0 - Double((self.offset + self.translation) * 0.0027))
                        }
                        
                        ListInputRow(value: self.$calcModel.partySize.double, inputStyle: .Integer, title: "Party Size", field: .partySize, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                            .id("\(self.calcModel.partySize)")
                            .opacity(1.0 - Double((self.offset + self.translation) * 0.0030))
                        
                        VenueButton()
                            .id("Venue")
                            .opacity(1.0 - Double((self.offset + self.translation) * 0.0032))
                        
                        ListInputRow(value: self.$calcModel.tipRate, inputStyle: .TwoDecimalPercent, title: "Tip %", field: .tipRate, background: self.colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
                            .id("\(self.calcModel.tipRate)")
                            .opacity(1.0 - Double((self.offset + self.translation) * 0.0035))
                    }
                
                ZStack {
                    
                    VenueSelectionView()
                        .offset(x: self.inputs.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
                
                    Keypad()
                        .offset(x: (self.inputs.activeField != .none && self.inputs.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
                    
                    ListStyleTotaledAmounts()
                        .offset(y: -(self.offset + self.translation))
                    
                }
                .padding(.top)
                .frame(maxHeight: geo.size.height / 3)
                .minimumScaleFactor(0.75)
                    
                
            }
            .padding()
            .frame(width: geo.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(self.colorScheme == .light ? .systemBackground : .secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geo.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.spring(response: 0.7, dampingFraction: 0.9, blendDuration: 1.0))
            .gesture (
                DragGesture().updating(self.$translation, body: { (value, state, _) in
                    state = value.translation.height
//                    print(state)
                    self.inputs.activeField = .none
                }).onEnded({ (value) in
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

struct MainPageSheet_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            MainPageSheet(maxHeight: geo.size.height).environmentObject(UserPreferences.sharedInstance)
        }
    }
}
