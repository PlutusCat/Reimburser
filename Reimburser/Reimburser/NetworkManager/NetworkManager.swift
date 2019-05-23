//
//  NetworkManager.swift
//  FacialAudit
//
//  Created by PlutusCat on 2019/1/2.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RealmSwift

let sessionManager: Alamofire.SessionManager = {
     let configuration = URLSessionConfiguration.default
     configuration.timeoutIntervalForRequest = 30
     return Alamofire.SessionManager(configuration: configuration)
}()

class NetworkManager: NSObject {

    /// 网络请求
    ///
    /// - Parameters:
    ///   - URLString: 请求地址
    ///   - method: 请求方式 [.get .post]
    ///   - paramet: 请求参数
    ///   - finishedCallback: 返回成功
    ///   - errorback: 返回失败
    @discardableResult
    class func request(URLString: String,
                       method: HTTPMethod = .post,
                       paramet: Parameters? = nil,
                       finishedCallback :  @escaping (_ result: Any) -> Void,
                       errorback : @escaping (_ result: Any) -> Void) -> DataRequest {
        let url = API.main()+URLString
        let request = sessionManager.request(url,
                                        method: method,
                                        parameters: paramet,
                                        encoding: JSONEncoding.default)
            .responseJSON { (response) in
                guard let result = response.result.value else {
                    errorback(response.result.error!)
                    return
                }
                printm("--- 请求的地址 ---")
                printm(url)
                printm("--- 请求的JSON ---")
                printm(JSON(paramet as Any))
                printm("--- 返回的JSON ---")
                printm(JSON(result))
                let model = BaseModel.from(dictionary: JSON(result).dictionaryValue)
//                if NetworkResult.isLoginFailure(code: model.code) {
//                    printm("登陆状态失效，需要重新的登陆")
//                    let tabBarVC = UIApplication.shared.keyWindow?.rootViewController
//                    if let bool = tabBarVC?.isEqual(LoginViewController.self), bool == false {
//                        let loginVC = LoginViewController()
//                        tabBarVC?.present(loginVC, animated: true, completion: nil)
//                        return
//                    }
//                }
                finishedCallback(result)
        }
        return request
    }
}

extension NetworkManager {

    /// 退出登录
    ///
    /// - Parameter sessionId: 用户 Token = LoginRealm.appSessionId
    public class func logOut(sessionId: String) {
        let paramet: Parameters = ["appSessionId": sessionId]
        NetworkManager.request(URLString: API.loginOut, paramet: paramet, finishedCallback: { (result) in
            let json = JSON(result).dictionaryValue
            let model = BaseModel.from(dictionary: json)
            if NetworkResult.isCompleted(code: model.code) {
                printm("退出登录，销毁 appSessionId 成功！")
            } else {
                printm("退出登录，销毁 appSessionId 失败！")
            }
        }) { _ in
            printm("退出登录，销毁 appSessionId 失败！")
        }
    }
}
