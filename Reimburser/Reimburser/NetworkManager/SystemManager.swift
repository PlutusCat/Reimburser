//
//  SystemManager.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class SystemManager: NSObject {
    public class func getVersion() -> String {
        let infoDic = Bundle.main.infoDictionary
        // 获取App的版本号
        let appVersion = infoDic?["CFBundleShortVersionString"] as! String
        // 获取App的build版本
        let appBuildVersion = infoDic?["CFBundleVersion"] as! String
        #if DEBUG
        let version = "DEBUG "+"v."+appVersion + "_" + appBuildVersion
        #else
        let version = "v."+appVersion
        #endif
        return version
    }

}
