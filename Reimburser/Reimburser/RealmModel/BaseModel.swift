//
//  BaseModel.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/5/9.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class BaseModel: Object {
    @objc dynamic var code = ""
    @objc dynamic var msg = ""

    @discardableResult
    class func from(dictionary: [String : SwiftyJSON.JSON]) -> BaseModel {
        let this = BaseModel()
        if let code = dictionary["code"]?.stringValue {
            this.code = code
        }
        if let msg = dictionary["msg"]?.stringValue {
            this.msg = msg
        }
        return this
    }
}
