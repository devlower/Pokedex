//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Angelica dos Santos on 06/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        
        let rootViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        
        return true
    }
}

