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
    dynamic var data: UserData!

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
            this.data = UserData.from(json: dataDict)
            if let token = dataDict["Planet-Access-Token"]?.stringValue {
                this.token = token
            }
        }
        return this
    }
}

class UserData: Object {
    dynamic var shareEnvelope: ShareEnvelope!
    dynamic var userInfo: UserInfo!

    class func from(json: [String : SwiftyJSON.JSON]) -> UserData {
        let this = UserData()
        if json.isEmpty {
            return this
        }
        if let shareEnvelope = json["shareEnvelope"]?.dictionaryValue {
            this.shareEnvelope = ShareEnvelope.from(json: shareEnvelope)
        }
        if let userInfo = json["userInfo"]?.dictionaryValue {
            this.userInfo = UserInfo.from(json: userInfo)
        }
        return this
    }
}

class ShareEnvelope: Object {
    dynamic var envelopeOrder: EnvelopeOrder!
    
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
    @objc dynamic var id = ""
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

    class func from(json: [String : SwiftyJSON.JSON]) -> EnvelopeOrder {
        let this = EnvelopeOrder()
        if json.isEmpty {
            return this
        }
        if let id = json["id"]?.stringValue {
            this.id = id
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

class UserInfo: Object {
    @objc dynamic var id = ""
    @objc dynamic var uid = ""
    @objc dynamic var account = ""
    @objc dynamic var phone = ""
    @objc dynamic var role = ""
    @objc dynamic var insertTime = ""
    @objc dynamic var updateTime = ""
    @objc dynamic var registrationType = ""
    
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

