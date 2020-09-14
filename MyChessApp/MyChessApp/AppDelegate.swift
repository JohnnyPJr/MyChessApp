//
//  AppDelegate.swift
//  MyChessApp
//
//  Created by John Platsis on 13/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController.init(rootViewController: WelcomeVC.init(nibName: "ChessTableViewController", bundle: Bundle.main))
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }
}

