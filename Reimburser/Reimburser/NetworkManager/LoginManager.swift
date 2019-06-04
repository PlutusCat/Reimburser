//
//  LoginManager.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

public enum LoginType: Int {
    case unknow = 0
    case wx = 1
    case phone = 2
}

class LoginManagerRealm: Object {
    @objc dynamic var id = loginManagerRealmKey
    @objc dynamic var token = ""
    @objc dynamic var type = 0
    
    override class func primaryKey() -> String? { return "id" }
    
}

class LoginManager: NSObject {

    public class func login(type: LoginType, token: String) {
        let realm = try! Realm()
        let value = ["id": loginManagerRealmKey,
                     "type": type.rawValue,
                     "token": token] as [String : Any]
        try! realm.write {
            realm.create(LoginManagerRealm.self, value: value, update: true)
        }
        NotificationCenter.default.post(name: NotificationNames.loginSuccess,
                                        object: type)
        
        /// 下载量统计
        let paramet: Parameters = ["tag": "Apple Store"]
        NetworkManager.request(URLString: API.freeTag,
                               paramet: paramet,
                               finishedCallback: { (result) in }) { (error) in }
    }
 
}
