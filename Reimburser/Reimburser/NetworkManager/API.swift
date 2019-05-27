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
}

class API {
    public class func main() -> String {
        #if DEBUG
        return "http://e60e71a6.ngrok.io/planet"
        #else
        return "https://"
        #endif
    }

}
