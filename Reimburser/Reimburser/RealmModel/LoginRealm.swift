//
//  LoginRealm.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/3/28.
//  Copyright © 2019 FacialAudit. All rights reserved.
//
/**
 {
 "code": 1,
 "msg": "OK",
 "data": {
 "shareEnvelope": {
 "envelopeOrder": {
 "id": 230,
 "recordSn": "321f2a9391064b34b11175768f6d1c19",
 "fromUid": "5f2c4be1172f8812006bba26466ca98d",
 "fromDisplay": 1,
 "fromStatus": 1,
 "toDisplay": 1,
 "toStatus": 0,
 "money": 1,
 "createTime": 1557210852516,
 "name": "系统提供的分享红包",
 "greetings": "",
 "description": "系统个月用户2d988ea9a1884167b6810cac2487ca11提供的分享红包",
 "type": 2,
 "indirectUser": "2d988ea9a1884167b6810cac2487ca11"
 }
 },
 "userInfo": {
 "id": "2d988ea9a1884167b6810cac2487ca11",
 "account": "18893873123",
 "phone": "18893873123",
 "role": "[0]",
 "insertTime": 1557209624000,
 "updateTime": 1557209624000,
 "registrationType": 1
 },
 "Planet-Access-Token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1SWQiOiIyZDk4OGVhOWExODg0MTY3YjY4MTBjYWMyNDg3Y2ExMSIsImV4cCI6MTU1NzIxNjAyMX0.nzOfUJnKvKS3_lGxVaL0ThEXmGcFyHAqZAPw1O35ZOY",
 "toBeReceiveEnvelopeOrder": []
 },
 "success": true
 }
 */

import UIKit
import RxRealm
import RealmSwift
import SwiftyJSON

class LoginRealm: Object {
    @objc dynamic var id = loginKey
    @objc dynamic var owner: BaseModel?
    @objc dynamic var token = ""
    @objc dynamic var success = ""
    dynamic var data: List<Object>!
    
    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> LoginRealm {
        let this = LoginRealm()
        if json.isEmpty {
            return this
        }
        this.owner = BaseModel.from(dictionary: json)
        if let dataDict = json["data"]?.dictionaryValue, dataDict.isEmpty == false {
            if let shareEnvelope = dataDict["shareEnvelope"]?.dictionaryValue {
                let value = ShareEnvelope.from(json: shareEnvelope)
            }
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

    class func from(json: [String : SwiftyJSON.JSON]) -> EnvelopeOrder {
        let this = EnvelopeOrder()
        if json.isEmpty {
            return this
        }
        if let id = json["id"]?.stringValue {
            this.id = id
        }
        return this
    }
}

class UserInfo: Object {
    
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

