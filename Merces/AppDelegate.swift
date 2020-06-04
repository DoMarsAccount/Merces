//
//  AppDelegate.swift
//  Merces
//
//  Created by Donovan McCray on 3/19/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

//
//  AppDelegate.swift
//  Mercii
//
//  Created by Donovan McCray on 12/13/16.
//  Copyright © 2016 Donovan McCray. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Types
    
    enum ShortcutIdentifier: String {
        case First
        case Second
        
        // MARK: - Initializers
        
        init?(fullType: String) {
            guard let last = fullType.components(separatedBy: ".").last else { return nil }
            
            self.init(rawValue: last)
        }
        
        // MARK: - Properties
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    // MARK: - Static Properties
    
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"
    
    // MARK: - Properties
    
    /*
     The app delegate must implement the window from UIApplicationDelegate
     protocol to use a main storyboard file.
     */
    var window: UIWindow?
    
    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
            
        }
        
        return shouldPerformAdditionalDelegateHandling
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        guard let shortcut = launchedShortcutItem else { return }
        
        var _ = handleShortcut(shortcutItem: shortcut)
        
        launchedShortcutItem = nil
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func handleShortcut( shortcutItem:UIApplicationShortcutItem ) -> Bool {
        
        // Construct an alert using the details of the shortcut used to open the application.
        
        let rootView = self.window!.rootViewController as! NavigationController
        
        if shortcutItem.localizedTitle == "My Merces" {
            
            let requestedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyMerces") as! MyMerces
            
            rootView.pushViewController(requestedViewController, animated: true)
            
        } else if shortcutItem.localizedTitle == "Color Picker" {
            
            let requestedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThemesPage") as! ThemesViewController
            
            rootView.pushViewController(requestedViewController, animated: true)
            
        }
        
        return (launchedShortcutItem != nil)
        
    }
    
    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        
        completionHandler(handleShortcut(shortcutItem: shortcutItem))
        
        
    }
    
    
}


