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
    /// 第三方授权
    open class var opportunityList: String {
        return "/api/user/login"
    }
    /// linkaccid
    open class var linkaccid: String {
        return "/bocAppOpportunity/getLinkaccid"
    }
    /// 订单确认
    open class var sureAppOpportunity: String {
        return "/bocAppOpportunity/sureAppOpportunity"
    }
}

class API {
    public class func main() -> String {
        #if DEBUG
        return "https://"
        #else
        return "https://"
        #endif
    }

}
