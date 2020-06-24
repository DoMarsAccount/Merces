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
    
    func body(content: Content) -> some View {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = (colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark)
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)!]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)!]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = UIColor(contrastingBlackOrWhiteColorOn: colorScheme == .light ? Themes.sharedInstance.mainColor : Themes.sharedInstance.mainColorDark, isFlat: true)!
        
        return ZStack{
            content
            VStack {
                Spacer()
            }
        }
    }
}

