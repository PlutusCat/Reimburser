//
//  Realm+Manager.swift
//  Quickworker
//
//  Created by PlutusCat on 2018/9/26.
//  Copyright © 2018 Quickworker. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    /// Realm 数据库配置，用于数据库的迭代更新
    public class func realmMigration() {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyyMMddHHmmss"
        let version = timeFormatter.string(from: date).floatValue()
        let schemaVersion: UInt64 = UInt64(exactly: version)!
        let config = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: { _, oldSchemaVersion in
            /* 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构 */
            if (oldSchemaVersion < schemaVersion) {}
        })
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            /* Realm 成功打开，迁移已在后台线程中完成 */
            if let fileURL = realm?.configuration.fileURL {
                printm("Realm 数据库配置成功: \(fileURL)")
            }
                /* 处理打开 Realm 时所发生的错误 */
            else if let error = error {
                printm("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }
    /// 删除所有 Realm
    public class func cleaner() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}

class RealmManager {
    /// 保存 realm.object 对象
    /// update: true
    /// - Parameter object: object 对象
    public class func save(object: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: true)
        }
    }
}
