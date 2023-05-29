//
//  AppDelegate.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 23/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setInitialController()
        return true
    }
    
    func setInitialController() {
        let window = UIWindow()
        window.rootViewController = BookListViewController()
        self.window = window
        window.makeKeyAndVisible()
    }

}

