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
        WXApi.registerApp(AppSecret.wxAppid)
        showHomeViewController()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = -1
        JPUSHService.resetBadge()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let presentedVC = window?.rootViewController?.presentedViewController, presentedVC.isKind(of: VideoPlayerController.self) {
            let playerVC = presentedVC as! VideoPlayerController
            if playerVC.isPresented {
                return .portrait
            } else {
                return .all
            }
        } else {
           return .portrait
        }
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
        window?.rootViewController = tabBarVC
    }
}

extension AppDelegate {
    private func jpush(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let jpushKey = AppSecret.jPushAppKey
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
//        #if DEBUG
//        JPUSHService.setDebugMode()
//        #else
//        JPUSHService.setLogOFF()
//        #endif

        JPUSHService.setLogOFF()

    }
}

extension AppDelegate: WXApiDelegate {
    func onReq(_ req: BaseReq) {
        if req.isKind(of: GetMessageFromWXReq.self) {
            printm("微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信")
        } else if req.isKind(of: ShowMessageFromWXReq.self) {
            let temp = req as! ShowMessageFromWXReq
            let msg = temp.message
            printm("标题", msg.title)
            printm("内容", msg.description)
            printm("附带信息", msg.mediaObject)
//            printm("缩略图", msg.thumbData?.length)
        } else if req.isKind(of: LaunchFromWXReq.self) {
            printm("从微信启动")
        }
    }
    func onResp(_ resp: BaseResp) {
        switch resp.errCode {
        case 0:
            printm("用户同意了微信授权")
            if resp.isKind(of: SendAuthResp.self) {
                let temp = resp as! SendAuthResp
                if let code = temp.code {
                    NetworkManager.wechatlogin(code: code)
                } else {
                    printm("获取微信授权失败")
                }
            }
        case -4:
            printm("用户拒绝了微信授权")
        case -2:
            printm("用户取消了微信授权")
        default:
            break
        }
    }
}

extension AppDelegate: JPUSHRegisterDelegate {

    /// 程序在运行时收到通知，点击通知栏进入app
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if let trigger = notification.request.trigger, trigger.isKind(of: UNPushNotificationTrigger.self) {
            JPUSHService.handleRemoteNotification(userInfo)
            printm("willPresent =", userInfo)
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
            printm("didReceive =", userInfo)
        } else {
            printm("didReceive -- 本地通知")
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
