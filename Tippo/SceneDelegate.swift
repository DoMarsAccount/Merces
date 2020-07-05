//
//  SceneDelegate.swift
//  TipTok
//
//  Created by Donovan McCray on 6/15/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import UIKit
import SwiftUI
import WatchConnectivity

class SceneDelegate: UIResponder, UIWindowSceneDelegate, WCSessionDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentView())
            self.window = window
            window.makeKeyAndVisible()
        }
        
//        if (WCSession.isSupported()) {
//            let session = WCSession.default
//            session.delegate = self
//            session.activate()
//            print("Scene did become active")
//            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPreferences", ofType: "plist")
//            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile!)
//            session.transferUserInfo(defaultPreferences as! [String : Any])
//        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        guard let shortcut = launchedShortcutItem else { return }
        _ = handleShortcut(shortcutItem: shortcut)
        launchedShortcutItem = nil
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    // MARK: - Widgets
    
    enum ShortcutIdentifier: String {
           case First
           case Second
           
           // MARK: Initializers
           
           init?(fullType: String) {
               guard let last = fullType.components(separatedBy: ".").last else { return nil }
               
               self.init(rawValue: last)
           }
           
           // MARK: Properties
           
           var type: String {
               return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
           }
       }
    // MARK: Static Properties
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"
    
    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    func handleShortcut( shortcutItem:UIApplicationShortcutItem ) -> Bool {
        
        // Construct an alert using the details of the shortcut used to open the application.
        
        let rootView = self.window!.rootViewController
        
        if shortcutItem.localizedTitle == "Personalize" {
            
            let requestedViewController = UIHostingController(rootView: PersonalizationPage().environmentObject(UserPreferences.sharedInstance))
            rootView?.present(requestedViewController, animated: true, completion: {
                
            })
            
        } else if shortcutItem.localizedTitle == "Themes" {
            
            let requestedViewController = UIHostingController(rootView: ThemesPage())
            
            rootView?.present(requestedViewController, animated: true, completion: {
                
            })
        }
        return (launchedShortcutItem != nil)
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleShortcut(shortcutItem: shortcutItem))
    }
    
    // MARK: - WCDelegate Methods
        
        func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            print("Watch Session did complete")
        }
        
        func sessionDidBecomeInactive(_ session: WCSession) {
            
        }
        
        func sessionDidDeactivate(_ session: WCSession) {
            
        }
        
        func sessionWatchStateDidChange(_ session: WCSession) {
            // Called when the watch gets paired with the phone
            if session.isWatchAppInstalled {
                // session.watchDirectoryURL is guaranteed non-nil when the app is installed
                // path to directory on the watch
                // the lifetime of this directory is tied to the watchAppInstalled property
                do {
                    print("Session Watch State Did Change")
                    let defaultPrefsFile = Bundle.main.path(forResource: "defaultPreferences", ofType: "plist")
                    let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile!)
                    UserDefaults(suiteName:"group.DoMarsToyBox.Merces")?.register(defaults: defaultPreferences! as! [String : AnyObject])
                    try session.updateApplicationContext((UserDefaults(suiteName:"group.DoMarsToyBox.Merces")?.dictionaryRepresentation())!)
                    
                } catch {
                    
                }
                
                // session.isComplicationEnabled
            }
        }

}

