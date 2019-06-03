//
//  LoginRealm.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/3/28.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import UIKit
import RxRealm
import RealmSwift
import SwiftyJSON

class LoginRealm: Object {
    @objc dynamic var id = loginKey
    @objc dynamic var owner: BaseModel?
    @objc dynamic var token = ""
    @objc dynamic var success = ""
    @objc dynamic var userInfo: UserInfo?
    @objc dynamic var shareEnvelope: ShareEnvelope?

    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> LoginRealm {
        let this = LoginRealm()
        if json.isEmpty {
            return this
        }
        this.owner = BaseModel.from(dictionary: json)
        if let success = json["success"]?.stringValue {
            this.success = success
        }
        if let dataDict = json["data"]?.dictionaryValue, dataDict.isEmpty == false {
            if let userInfo = dataDict["userInfo"]?.dictionaryValue {
                this.userInfo = UserInfo.from(json: userInfo)
            }
            if let shareEnvelope = dataDict["shareEnvelope"]?.dictionaryValue {
                this.shareEnvelope = ShareEnvelope.from(json: shareEnvelope)
            }
            if let token = dataDict["Planet-Access-Token"]?.stringValue {
                this.token = token
            }
        }
        return this
    }
}

class ShareEnvelope: Object {
    @objc dynamic var id = shareEnvelopeKey
    @objc dynamic var envelopeOrder: EnvelopeOrder?
    
    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> ShareEnvelope {
        let this = ShareEnvelope()
        if json.isEmpty {
            return this
        }
        if let envelopeOrder = json["envelopeOrder"]?.dictionaryValue {
            this.envelopeOrder = EnvelopeOrder.from(json: envelopeOrder)
        }
        return this
    }
}

class EnvelopeOrder: Object {
    @objc dynamic var id = envelopeOrderKey
    @objc dynamic var uid = ""
    @objc dynamic var recordSn = ""
    @objc dynamic var fromUid = ""
    @objc dynamic var fromDisplay = ""
    @objc dynamic var fromStatus = ""
    @objc dynamic var toDisplay = ""
    @objc dynamic var toStatus = ""
    @objc dynamic var money = ""
    @objc dynamic var createTime = ""
    @objc dynamic var name = ""
    @objc dynamic var greetings = ""
    @objc dynamic var _description = ""
    @objc dynamic var type = ""
    @objc dynamic var indirectUser = ""

    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> EnvelopeOrder {
        let this = EnvelopeOrder()
        if json.isEmpty {
            return this
        }
        if let uid = json["id"]?.stringValue {
            this.uid = uid
        }
        if let recordSn = json["recordSn"]?.stringValue {
            this.recordSn = recordSn
        }
        if let fromUid = json["fromUid"]?.stringValue {
            this.fromUid = fromUid
        }
        if let fromDisplay = json["fromDisplay"]?.stringValue {
            this.fromDisplay = fromDisplay
        }
        if let fromStatus = json["fromStatus"]?.stringValue {
            this.fromStatus = fromStatus
        }
        if let toDisplay = json["toDisplay"]?.stringValue {
            this.toDisplay = toDisplay
        }
        if let toStatus = json["toStatus"]?.stringValue {
            this.toStatus = toStatus
        }
        if let money = json["money"]?.stringValue {
            this.money = money
        }
        if let createTime = json["createTime"]?.stringValue {
            this.createTime = createTime
        }
        if let name = json["name"]?.stringValue {
            this.name = name
        }
        if let greetings = json["greetings"]?.stringValue {
            this.greetings = greetings
        }
        if let description = json["description"]?.stringValue {
            this._description = description
        }
        if let type = json["type"]?.stringValue {
            this.type = type
        }
        if let indirectUser = json["indirectUser"]?.stringValue {
            this.indirectUser = indirectUser
        }
        return this
    }
}

/**
 {
 "province" : "北京",
 "gender" : 1,
 "avatar" : "http:\/\/user-qmbx.oss-cn-beijing.aliyuncs.com\/583984753746444288",
 "updateTime" : 1559303216000,
 "country" : "中国",
 "wechat" : "oY9ir1VfXxdPHdzMdEZCdbvtRT1c",
 "nick" : "PlutusCat",
 "insertTime" : 1559303216000,
 "city" : "",
 "role" : "0",
 "id" : "583984755861565440",
 "accountStatus" : 1,
 "registrationType" : 3,
 "account" : "oY9ir1VfXxdPHdzMdEZCdbvtRT1c"
 }
 */
class UserInfo: Object {
    @objc dynamic var id = userInfoKey
    @objc dynamic var uid = ""
    @objc dynamic var account = ""
    @objc dynamic var phone = ""
    @objc dynamic var role = ""
    @objc dynamic var insertTime = ""
    @objc dynamic var updateTime = ""
    @objc dynamic var registrationType = ""
    @objc dynamic var province = ""
    @objc dynamic var gender = ""
    @objc dynamic var avatar = ""
    @objc dynamic var city = ""
    @objc dynamic var country = ""
    @objc dynamic var nick = ""
    @objc dynamic var accountStatus = ""
    
    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> UserInfo {
        let this = UserInfo()
        if json.isEmpty {
            return this
        }
        if let uid = json["id"]?.stringValue {
            this.uid = uid
        }
        if let account = json["account"]?.stringValue {
            this.account = account
        }
        if let phone = json["phone"]?.stringValue {
            this.phone = phone
        }
        if let role = json["role"]?.stringValue {
            this.role = role
        }
        if let insertTime = json["insertTime"]?.stringValue {
            this.insertTime = insertTime
        }
        if let updateTime = json["updateTime"]?.stringValue {
            this.updateTime = updateTime
        }
        if let registrationType = json["registrationType"]?.stringValue {
            this.registrationType = registrationType
        }
        if let province = json["province"]?.stringValue {
            this.province = province
        }
        if let gender = json["gender"]?.stringValue {
            this.gender = gender
        }
        if let avatar = json["avatar"]?.stringValue {
            this.avatar = avatar
        }
        if let city = json["city"]?.stringValue {
            this.city = city
        }
        if let country = json["country"]?.stringValue {
            this.country = country
        }
        if let nick = json["nick"]?.stringValue {
            this.nick = nick
        }
        if let accountStatus = json["accountStatus"]?.stringValue {
            this.accountStatus = accountStatus
        }
        return this
    }
}

extension LoginRealm {
    public class func remove() {
        let realm = try! Realm()
        if let user = realm.object(ofType: LoginRealm.self, forPrimaryKey: loginKey) {
            try! realm.write {
                realm.delete(user)
            }
        }
    }
}

//extension LoginRealm {
//    public class func reload() {
//        let realm = try! Realm()
//        let loginRealm = realm.object(ofType: LoginRealm.self, forPrimaryKey: loginKey)
//        if let loginRealm = loginRealm {
//            try! realm.write {
//                loginRealm.password = ""
//            }
//        }
//    }
//}

