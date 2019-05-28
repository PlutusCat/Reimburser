//
//  AppDelegate.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/23.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Realm.realmMigration()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        jpush(launchOptions: launchOptions)
        showHomeViewController()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = -1
        JPUSHService.resetBadge()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            printm("resCode--", resCode, " registrationID---", registrationID ?? "没有 registrationID")
        }
    }

}

extension AppDelegate {
    private func showHomeViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .background
        window?.makeKeyAndVisible()
        let tabBarVC = MainTabBarController()
        tabBarVC.selectedIndex = 1
        window?.rootViewController = tabBarVC
    }
}

extension AppDelegate {
    private func jpush(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let jpushKey = "6fb975b4f30a18877adf9d10"
        #if DEBUG
        let channel = "DEBUG"
        let  isProduction = false
        #else
        let channel = "RELEASE"
        let isProduction = true
        #endif
        let entity = JPUSHRegisterEntity()
        entity.types = 1 << 0 | 1 << 1 | 1 << 2
        let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions,
                           appKey: jpushKey,
                           channel: channel,
                           apsForProduction: isProduction,
                           advertisingIdentifier: advertisingId)
        #if DEBUG
        JPUSHService.setDebugMode()
        #else
        JPUSHService.setLogOFF()
        #endif

        JPUSHService.setAlias("17600800656", completion: { (iResCode, iAlias, _) in
            if iResCode == 0 {
                printm("极光别名注册成功 iAlias=\(iAlias ?? "iAlias 为空")" )
            }
        }, seq: 000)

        // 极光推送，接收自定义消息
//        let defaultCenter = NotificationCenter.default
//        defaultCenter.addObserver(self, selector: #selector(networkDidReceiveMessage), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
    }
}


extension AppDelegate: JPUSHRegisterDelegate {

    /// 程序在运行时收到通知，点击通知栏进入app
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if let trigger = notification.request.trigger, trigger.isKind(of: UNPushNotificationTrigger.self) {
            JPUSHService.handleRemoteNotification(userInfo)
        } else {
            printm("willPresent -- 本地通知")
        }
        let intt = UNNotificationPresentationOptions.alert.rawValue
        completionHandler(Int(intt))
    }
    
    /// 程序在后台时收到通知，点击通知栏进入app
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if let trigger = response.notification.request.trigger, trigger.isKind(of: UNPushNotificationTrigger.self) {
            JPUSHService.handleRemoteNotification(userInfo)
        } else {
            printm("withCompletionHandler -- 本地通知")
        }
        completionHandler()
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        if let trigger = notification?.request.trigger, trigger.isKind(of: UNPushNotificationTrigger.self) {
            printm("从通知界面直接进入应用")
        } else {
            printm("从通知设置界面进入应用")
        }
    }
}
