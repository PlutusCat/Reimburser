//
//  LoginManager.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift

public enum LoginType: Int {
    case unknow = 0
    case wx = 1
    case phone = 2
}

class LoginManagerRealm: Object {
    @objc dynamic var id = loginManagerRealmKey
    @objc dynamic var type = 0
    
    override class func primaryKey() -> String? { return "id" }
    
}

class LoginManager: NSObject {

    public class func login(type: LoginType) {
        let realm = try! Realm()
        let value = ["id": loginManagerRealmKey, "type": type.rawValue] as [String : Any]
        try! realm.write {
            realm.create(LoginManagerRealm.self, value: value, update: true)
        }
        NotificationCenter.default.post(name: NotificationNames.loginSuccess,
                                        object: type)
    }
    
    /// 获取当前用户登陆方式
    open class var type: LoginType {
        let realm = try! Realm()
        if let user = realm.object(ofType: WXLoginRealm.self, forPrimaryKey: wxLoginKey), !user.openid.isEmpty {
           return LoginType.wx
        } else if let user = realm.object(ofType: LoginRealm.self, forPrimaryKey: loginKey), !user.token.isEmpty {
            return LoginType.phone
        } else {
            return LoginType.unknow
        }
    }
    
}
