//
//  WalletRealm.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/6/3.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class WalletInfoRealm: Object {
    @objc dynamic var id = walletKey
    @objc dynamic var owner: BaseModel?
    @objc dynamic var money = ""
    
    override class func primaryKey() -> String? { return "id" }
    
    class func from(json: [String : SwiftyJSON.JSON]) -> WalletInfoRealm {
        let this = WalletInfoRealm()
        if json.isEmpty {
            return this
        }
        this.owner = BaseModel.from(dictionary: json)
        if let dataDict = json["data"]?.dictionaryValue, dataDict.isEmpty == false {
            if let money = json["money"]?.stringValue {
                this.money = money
            } else {
                this.money = "0.00"
            }
        }
        return this
    }
}
