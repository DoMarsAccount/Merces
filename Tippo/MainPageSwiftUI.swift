////
////  MainPageSwiftUI.swift
////  TipTok
////
////  Created by Donovan McCray on 6/14/20.
////  Copyright © 2020 DoMarsToyBox. All rights reserved.
////
//
//import SwiftUI
//
//struct MainPageSwiftUI: View {
//    @Environment(\.colorScheme) var colorScheme
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass!
//    @State private var isSettingsActive: Bool = false
//    @EnvironmentObject var userPrefs: UserPreferences
//    @ObservedObject var inputs = InputProcessing.sharedInstance
//    @ObservedObject var themes = Themes.sharedInstance
//
//    var body: some View {
//        VStack {
//            MainPageTopSubview()
//                .padding(.top)
//                .minimumScaleFactor(0.75)
//
//            MainPageMiddleSubview()
//                .minimumScaleFactor(0.8)
//            
//            ZStack {
//
//                VenueSelectionView()
//                    .offset(x: self.inputs.activeField == .venue ? 0 : UIScreen.main.bounds.maxX)
//
//                Keypad()
//                    .offset(x: (self.inputs.activeField != .none && self.inputs.activeField != .venue) ? 0 : UIScreen.main.bounds.maxX)
//
//                MainPageBottomSubview()
//                    .offset(x: self.inputs.activeField == .none ? 0 : UIScreen.main.bounds.maxX)
//
//            }
//                .minimumScaleFactor(0.75)
//                .padding(.bottom)
//                .animation(.spring(response: 0.7, dampingFraction: 0.7, blendDuration: 1.0))
////                        .animation(.interpolatingSpring(mass: 1.0, stiffness: 0.0, damping: 0.7, initialVelocity: 0.7))
//        }
//    }
//}
//
//struct ClassicStyle: ViewModifier {
//    @Environment(\.colorScheme) var colorScheme
//    @ObservedObject var themes = Themes.sharedInstance
//    @Binding var isClassic: Bool
//    func body(content: Content) -> some View {
//        Group  {
//            if isClassic {
//                content
//                    .navigationBarTitle(Text("Tippo"), displayMode: .inline)
//                    .background(NavigationConfigurator { nc in
//                        nc.navigationBar.barTintColor = (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor)
//                        nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
//                        nc.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)
//                    })
//            } else {
//                content.navigationBarTitle(Text("Tippo"), displayMode: .automatic)
//            }
//        }
//    }
//}
//
//
//struct MainPageSwiftUI_Previews: PreviewProvider {
//    static var previews: some View {
//        MainPageSwiftUI()
//            .environmentObject(UserPreferences.sharedInstance)
//    }
//}
