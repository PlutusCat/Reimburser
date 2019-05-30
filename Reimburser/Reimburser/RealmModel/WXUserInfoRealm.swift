//
//  WXUserInfoRealm.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class WXUserInfoRealm: Object {
    @objc dynamic var id = wxUserInfoKey
    @objc dynamic var sex = ""
    @objc dynamic var province = ""
    @objc dynamic var country = ""
    @objc dynamic var unionid = ""
    @objc dynamic var nickname = ""
    @objc dynamic var city = ""
    @objc dynamic var language = ""
    @objc dynamic var headimgurl = ""
    
    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> WXUserInfoRealm {
        let this = WXUserInfoRealm()
        if json.isEmpty {
            return this
        }
        if let sex = json["sex"]?.stringValue {
            this.sex = sex
        }
        if let province = json["province"]?.stringValue {
            this.province = province
        }
        if let country = json["country"]?.stringValue {
            this.country = country
        }
        if let unionid = json["unionid"]?.stringValue {
            this.unionid = unionid
        }
        if let nickname = json["nickname"]?.stringValue {
            this.nickname = nickname
        }
        if let city = json["city"]?.stringValue {
            this.city = city
        }
        if let language = json["language"]?.stringValue {
            this.language = language
        }
        if let headimgurl = json["headimgurl"]?.stringValue {
            this.headimgurl = headimgurl
        }
        return this
    }
}

