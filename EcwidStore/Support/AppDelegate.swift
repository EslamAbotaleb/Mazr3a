//
//  AppDelegate.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = StoreTabBarController()
        window?.makeKeyAndVisible()
        configureNavigationBar()
        FirebaseApp.configure()

        return true
    }
    
    func configureNavigationBar(){
        UINavigationBar.appearance().isHidden = true
    }
    
    
    
}

