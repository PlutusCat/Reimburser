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
                       addMainUrl: Bool = true,
                       method: HTTPMethod = .post,
                       paramet: Parameters? = nil,
                       finishedCallback :  @escaping (_ result: Any) -> Void,
                       errorback : @escaping (_ result: Any) -> Void) -> DataRequest {
        var url = ""
        if addMainUrl {
            url = API.main()+URLString
        } else {
            url = URLString
        }
        
        var headers: HTTPHeaders?
        let realm = try! Realm()
        if let loginManager = realm.object(ofType: LoginManagerRealm.self, forPrimaryKey: loginManagerRealmKey) {
            let token = loginManager.token
            headers = ["token": token]
        }

        let request = sessionManager.request(url,
                                        method: method,
                                        parameters: paramet,
                                        encoding: JSONEncoding.default,
                                        headers: headers)
            .responseJSON { (response) in
                printm("--- 请求的地址 ---")
                printm(url)
                printm("--- 请求的JSON ---")
                printm(JSON(paramet as Any))
                guard let result = response.result.value else {
                    errorback(response.result.error!)
                    printm("--- 请求出错 ---")
                    return
                }
                printm("--- 返回的JSON ---")
                printm(JSON(result))
//                let model = BaseModel.from(dictionary: JSON(result).dictionaryValue)
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
    public class func logOut() {
        
        let realm = try! Realm()
        LoginRealm.remove()
        WXLoginRealm.remove()
        let value = ["id": loginManagerRealmKey, "type": 0] as [String : Any]
        try! realm.write {
            realm.create(LoginManagerRealm.self, value: value, update: true)
        }

        NetworkManager.request(URLString: API.loginOut, method: .get, finishedCallback: { (result) in
            let json = JSON(result).dictionaryValue
            let model = BaseModel.from(dictionary: json)
            if NetworkResult.isCompleted(code: model.code) {
                printm("退出登录成功！")
            } else {
                printm("退出登录失败！")
            }
        }) { _ in
            printm("退出登录失败！")
        }
    }
    
    /// 微信接口 通过code获取access_token
    ///
    /// - Parameter code: 填写第一步获取的code参数
    public class func getWechatToken(code: String) {
        let appid = "appid="+AppSecret.wxAppid
        let secret = "&secret="+AppSecret.wxAppSecret
        let rCode = "&code="+code
        let main = "https://api.weixin.qq.com/sns/oauth2/access_token?"
        let url = main+appid+secret+rCode+"&grant_type=authorization_code"
        
        NetworkManager.request(URLString: url, addMainUrl: false, method: .get, finishedCallback: { (result) in
            let json = JSON(result).dictionaryValue
            DispatchQueue.main.async {
                let realm = try! Realm()
                let model = WXLoginRealm.from(json: json)
                try! realm.write {
                    realm.add(model, update: true)
                }
                NetworkManager.wxGetUserinfor(model: model)
            }
        }) { (error) in
            
        }
    }
    
    /// 微信获取用户信息接口
    ///
    /// - Parameter model: WXLoginRealm
    public class func wxGetUserinfor(model: WXLoginRealm) {
        let main = "https://api.weixin.qq.com/sns/userinfo?"
        let access_token = "access_token="+model.access_token
        let openid = "&openid="+model.openid
        let url = main+access_token+openid
        NetworkManager.request(URLString: url, addMainUrl: false, method: .get, finishedCallback: { (result) in
            let json = JSON(result).dictionaryValue
            DispatchQueue.main.async {
                let realm = try! Realm()
                let model = WXUserInfoRealm.from(json: json)
                try! realm.write {
                    realm.add(model, update: true)
                }
                JPUSHService.setAlias(model.unionid, completion: { (iResCode, iAlias, _) in
                    if iResCode == 0 {
                        printm("极光别名注册成功 iAlias=\(iAlias ?? "iAlias 为空")" )
                    }
                }, seq: 000)
//                LoginManager.login(type: .wx)
            }
        }) { (error) in
            
        }
    }
    
    public class func wechatlogin(code: String) {
        let paramet: Parameters = ["code": code,
                                   "type": "third",
                                   "app": "wechat"]
        NetworkManager.request(URLString: API.wechatlogin, paramet: paramet, finishedCallback: { (result) in
            
            let json = JSON(result).dictionaryValue
            let model = LoginRealm.from(json: json)
            if let code = model.owner?.code, NetworkResult.isCompleted(code: code) {
                LoginManager.login(type: .wx, token: model.token)
            } else {
                printm(model.owner?.msg ?? "第三方授权失败")
            }
            
        }) { (error) in
            printm("网络出现错误")
        }
    }
    
}
