//
//  VideoEnvelopeOrderRealm.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/6/4.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class VideoEnvelopeOrderRealm: Object {
    @objc dynamic var id = videoEnvelopeOrderKey
    @objc dynamic var owner: BaseModel?
    @objc dynamic var uid = ""
    @objc dynamic var recordSn = ""
    @objc dynamic var fromUid = ""
    @objc dynamic var fromDisplay = ""
    @objc dynamic var fromStatus = ""
    @objc dynamic var toUid = ""
    @objc dynamic var toDisplay = ""
    @objc dynamic var toStatus = ""
    @objc dynamic var money = ""
    @objc dynamic var createTime = ""
    @objc dynamic var name = ""
    @objc dynamic var greetings = ""
    @objc dynamic var _description = ""
    @objc dynamic var type = ""
    
    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> VideoEnvelopeOrderRealm {
        let this = VideoEnvelopeOrderRealm()
        if json.isEmpty {
            return this
        }
        this.owner = BaseModel.from(dictionary: json)
        if let dataDict = json["data"]?.dictionaryValue, dataDict.isEmpty == false {
            if let envelopeOrder = json["envelopeOrder"]?.dictionary {
                if let uid = envelopeOrder["id"]?.stringValue {
                    this.uid = uid
                }
                if let recordSn = envelopeOrder["recordSn"]?.stringValue {
                    this.recordSn = recordSn
                }
                if let fromUid = envelopeOrder["fromUid"]?.stringValue {
                    this.fromUid = fromUid
                }
                if let fromDisplay = envelopeOrder["fromDisplay"]?.stringValue {
                    this.fromDisplay = fromDisplay
                }
                if let fromStatus = envelopeOrder["fromStatus"]?.stringValue {
                    this.fromStatus = fromStatus
                }
                if let toUid = envelopeOrder["toUid"]?.stringValue {
                    this.toUid = toUid
                }
                if let toDisplay = envelopeOrder["toDisplay"]?.stringValue {
                    this.toDisplay = toDisplay
                }
                if let toStatus = envelopeOrder["toStatus"]?.stringValue {
                    this.toStatus = toStatus
                }
                if let money = envelopeOrder["money"]?.stringValue {
                    this.money = money
                } else {
                    this.money = "0.00"
                }
                if let createTime = envelopeOrder["createTime"]?.stringValue {
                    this.createTime = createTime
                }
                if let name = envelopeOrder["name"]?.stringValue {
                    this.name = name
                }
                if let greetings = envelopeOrder["greetings"]?.stringValue {
                    this.greetings = greetings
                }
                if let description = envelopeOrder["description"]?.stringValue {
                    this._description = description
                }
                if let type = envelopeOrder["type"]?.stringValue {
                    this.type = type
                }
            }
        }
        return this
    }
}
