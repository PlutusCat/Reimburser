//
//  API.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/5/9.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import Foundation

extension API {
    /// 隐私政策 rul
    open class var privacyURL: String {
        return "http://www.taomibuy.cn/planet/api/free/p2"
    }
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
    /// 获取钱包余额
    open class var walletInfo: String {
        return "/api/wallet/info"
    }
    /// 个人钱包明细查询
    open class var walletBill: String {
        return "/api/wallet/log/bill"
    }
    /// 上传发票
    open class var credentialUpload: String {
        return "/api/consumption/credential/upload"
    }
}

class API {
    public class func main() -> String {
        #if DEBUG
        return "http://61a325e9.ngrok.io/planet"
//        return "http://www.taomibuy.cn/planet"
        #else
        return "http://www.taomibuy.cn/planet"
        #endif
    }
}

class wechatAPI {
    /// 统一下单
    open class var unifiedorder: String {
        return "https://api.mch.weixin.qq.com/pay/unifiedorder"
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
