//
//  AppDelegate.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/23.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        showHomeViewController()
        return true
    }
}

extension AppDelegate {
    private func showHomeViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .background
        window?.makeKeyAndVisible()
        let tabBarVC = MainTabBarController()
        tabBarVC.selectedIndex = 0
        window?.rootViewController = tabBarVC
    }
}

