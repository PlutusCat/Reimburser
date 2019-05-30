//
//  API.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/5/9.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import Foundation

extension API {
    /// 登陆接口
    open class var login: String {
        return "/api/user/login"
    }
    /// 退出登录
    open class var loginOut: String {
        return "/api/user/logout"
    }
    /// 视频列表
    open class var videoList: String {
        return "/api/video/list"
    }
    /// 第三方授权
    open class var wechatlogin: String {
        return "/api/user/login"
    }
}

class API {
    public class func main() -> String {
        #if DEBUG
        return "http://7ee63db5.ngrok.io/planet"
        #else
        return "http://www.taomibuy.cn/planet"
        #endif
    }
}

class AppSecret {
    /// 微信 appid
    open class var wxAppid: String {
        return "wxa8098c7baeb6356c"
    }
    /// 微信 AppSecret
    open class var wxAppSecret: String {
        return "f448b0a024b486187d2392b3c399a099"
    }
    /// 极光 AppKey
    open class var jPushAppKey: String {
        return "6fb975b4f30a18877adf9d10"
    }
}
