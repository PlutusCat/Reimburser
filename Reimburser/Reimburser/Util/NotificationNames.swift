//
//  NotificationNames.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class NotificationNames: NSObject {
    /// 登录成功
    public class var loginSuccess: NSNotification.Name {
        return NSNotification.Name(rawValue: "NotificationNames_loginSuccess")
    }
}
