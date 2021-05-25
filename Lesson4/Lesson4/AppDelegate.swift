//
//  AppDelegate.swift
//  Lesson4
//
//  Created by Михаил Беленко on 18.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootController = RootTabBarController()
        window?.backgroundColor = .white
        
        window!.rootViewController = rootController
        window!.makeKeyAndVisible()
        
        return true
    }
}

