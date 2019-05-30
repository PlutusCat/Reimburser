//
//  Date_Ex.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : Any {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
}
