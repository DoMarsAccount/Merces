//
//  NavigationConfigurator.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI
import ChameleonFramework

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            nc.setStatusBarStyle(UIStatusBarStyleContrast)  
            self.configure(nc)
        }
    }

}

struct NavigationConfigurator_Previews: PreviewProvider {
    static var previews: some View {
        NavigationConfigurator()
    }
}

struct NavigationBarModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var backgroundColor: UIColor?
    
    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true)!]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true)!]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: true)!

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
//                    Color(self.backgroundColor ?? .clear)
//                        .frame(height: geometry.safeAreaInsets.top)
//                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}


extension View {
 
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}
