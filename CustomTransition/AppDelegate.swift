//
//  AppDelegate.swift
//  CustomTransition
//
//  Created by Hut on 2021/6/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let firstVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nvc = UINavigationController(rootViewController: firstVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        
        return true
    }

}

