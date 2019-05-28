//
//  VideosRealm.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/28.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RxRealm
import RealmSwift
import SwiftyJSON

class VideosRealm: Object {
    @objc dynamic var id = videosKey
    @objc dynamic var owner: BaseModel?
    dynamic var data: VideosData?
    
    class func from(json: [String : SwiftyJSON.JSON]) -> VideosRealm {
        let this = VideosRealm()
        if json.isEmpty {
            return this
        }
        this.owner = BaseModel.from(dictionary: json)
        if let dataDict = json["data"]?.dictionaryValue, dataDict.isEmpty == false {
            this.data = VideosData.from(json: dataDict)
        }
        return this
    }
}

class VideosData: Object {
    @objc dynamic var size = ""
    @objc dynamic var current = ""
    @objc dynamic var total = ""
    dynamic var records: List<Records>?
    
    class func from(json: [String : SwiftyJSON.JSON]) -> VideosData {
        let this = VideosData()
        if json.isEmpty {
            return this
        }
        if let size = json["size"]?.stringValue {
            this.size = size
        }
        if let current = json["current"]?.stringValue {
            this.current = current
        }
        if let total = json["total"]?.stringValue {
            this.total = total
        }
        if let listArray = json["records"]?.arrayValue {
            let records = List<Records>()
            autoreleasepool {
                for i in 0..<listArray.count {
                    let value = listArray[i].dictionaryValue
                    let record = Records.from(json: value)
                    records.append(record)
                }
            }
            this.records = records
        }
        return this
    }
}

class Records: Object {
    @objc dynamic var label = ""
    @objc dynamic var record_description = ""
    @objc dynamic var merchant = ""
    @objc dynamic var commentVolume = ""
    @objc dynamic var playVolume = ""
    @objc dynamic var updateTime = ""
    @objc dynamic var record_id = ""
    @objc dynamic var cover = ""
    @objc dynamic var collectVolume = ""
    @objc dynamic var url = ""
    @objc dynamic var starVolume = ""
    @objc dynamic var watched = ""
    @objc dynamic var type = ""
    @objc dynamic var author = ""
    @objc dynamic var title = ""
    @objc dynamic var shareVolume = ""
    @objc dynamic var insertTime = ""
    @objc dynamic var introduction = ""
    @objc dynamic var status = ""
    
    class func from(json: [String : SwiftyJSON.JSON]) -> Records {
        let this = Records()
        if json.isEmpty {
            return this
        }
        if let label = json["label"]?.stringValue {
            this.label = label
        }
        if let description = json["description"]?.stringValue {
            this.record_description = description
        }
        if let merchant = json["merchant"]?.stringValue {
            this.merchant = merchant
        }
        if let commentVolume = json["commentVolume"]?.stringValue {
            this.commentVolume = commentVolume
        }
        if let playVolume = json["playVolume"]?.stringValue {
            this.playVolume = playVolume
        }
        if let updateTime = json["updateTime"]?.stringValue {
            this.updateTime = updateTime
        }
        if let id = json["id"]?.stringValue {
            this.record_id = id
        }
        if let cover = json["cover"]?.stringValue {
            this.cover = cover
        }
        if let collectVolume = json["collectVolume"]?.stringValue {
            this.collectVolume = collectVolume
        }
        if let url = json["url"]?.stringValue {
            this.url = url
        }
        if let starVolume = json["starVolume"]?.stringValue {
            this.starVolume = starVolume
        }
        if let watched = json["watched"]?.stringValue {
            this.watched = watched
        }
        if let type = json["type"]?.stringValue {
            this.type = type
        }
        if let author = json["author"]?.stringValue {
            this.author = author
        }
        if let title = json["title"]?.stringValue {
            this.title = title
        }
        if let shareVolume = json["shareVolume"]?.stringValue {
            this.shareVolume = shareVolume
        }
        if let insertTime = json["insertTime"]?.stringValue {
            this.insertTime = insertTime
        }
        if let introduction = json["introduction"]?.stringValue {
            this.introduction = introduction
        }
        if let status = json["status"]?.stringValue {
            this.status = status
        }
        return this
    }
}
