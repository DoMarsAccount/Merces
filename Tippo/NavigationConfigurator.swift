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
    @ObservedObject var themes = Themes.sharedInstance
    
    func body(content: Content) -> some View {
        if self.themes.shouldReloadTheme {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithTransparentBackground()
            coloredAppearance.backgroundColor = (colorScheme == .light ? self.themes.mainColor : self.themes.mainColorDark)
            coloredAppearance.titleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)!]
            
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().compactAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            UINavigationBar.appearance().tintColor = UIColor(contrastingBlackOrWhiteColorOn: (self.colorScheme == .dark ? self.themes.mainColorDark : self.themes.mainColor), isFlat: true)
            print("Theme should reload")
            self.themes.shouldReloadTheme = false
        }
        
        return ZStack {
            content
            
            VStack {
                Spacer()
            }
        }
    }
}

