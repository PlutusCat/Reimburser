//
//  NotificationNames.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import IJKMediaFramework

class NotificationNames: NSObject {
    /// 登录成功
    public class var loginSuccess: NSNotification.Name {
        return NSNotification.Name(rawValue: "NotificationNames_loginSuccess")
    }
    /// 退出成功
    public class var logoutSuccess: NSNotification.Name {
        return NSNotification.Name(rawValue: "NotificationNames_logoutSuccess")
    }
}

class IJKNames {
    /// 播放完成
    public class var didFinish: NSNotification.Name {
        return NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish
    }
}
