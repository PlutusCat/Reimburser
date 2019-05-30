//
//  WXLoginRealm.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class WXLoginRealm: Object {
    @objc dynamic var id = wxLoginKey
    @objc dynamic var openid = ""
    @objc dynamic var refresh_token = ""
    @objc dynamic var scope = ""
    @objc dynamic var expires_in = ""
    @objc dynamic var unionid = ""
    @objc dynamic var access_token = ""

    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> WXLoginRealm {
        let this = WXLoginRealm()
        if json.isEmpty {
            return this
        }
        if let openid = json["openid"]?.stringValue {
            this.openid = openid
        }
        if let refresh_token = json["refresh_token"]?.stringValue {
            this.refresh_token = refresh_token
        }
        if let scope = json["scope"]?.stringValue {
            this.scope = scope
        }
        if let expires_in = json["expires_in"]?.stringValue {
            this.expires_in = expires_in
        }
        if let unionid = json["unionid"]?.stringValue {
            this.unionid = unionid
        }
        if let access_token = json["access_token"]?.stringValue {
            this.access_token = access_token
        }
        return this
    }
}

/**
 {
 "sex" : 1,
 "province" : "Beijing",
 "openid" : "ovAqw5yXEuVkQWNOvMmy-Ghk8ckA",
 "privilege" : [
 
 ],
 "country" : "CN",
 "unionid" : "oY9ir1VfXxdPHdzMdEZCdbvtRT1c",
 "nickname" : "PlutusCat",
 "city" : "",
 "language" : "zh_CN",
 "headimgurl" : "http:\/\/thirdwx.qlogo.cn\/mmopen\/vi_32\/DYAIOgq83eoE0ia1SeIBlXFcmb1jSJMSlwsaY23O9l4VWcYJCfrAgfdVumAxlAeW6opYL6FUxmWLGVTO6AMyKEw\/132"
 }
 */
