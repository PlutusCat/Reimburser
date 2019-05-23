//
//  NetworkResult.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/5/7.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import UIKit

class NetworkResult: NSObject {

    public class func isCompleted(code: String) -> Bool {
        guard code == ResultCode.successful.rawValue else {
            return false
        }
        return true
    }

    /// 登陆状态失效
//    public class func isLoginFailure(code: String) -> Bool {
//        guard code == ResultCode.loginError.rawValue else {
//            return false
//        }
//        return true
//    }

}

public enum ResultCode: String {
    /// 返回成功
    case successful = "1"
    /// 用户登陆失败
//    case loginError = ""
    case error = ""
}
