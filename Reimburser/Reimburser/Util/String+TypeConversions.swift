//
//  String+TypeConversions.swift
//  Quickworker
//
//  Created by PlutusCat on 2018/9/26.
//  Copyright © 2018 Quickworker. All rights reserved.
//

import Foundation
import UIKit

extension String {
    public func intValue() -> Int {
        var cgInt: Int = 0
        if let doubleValue = Double(self) {
            cgInt = Int(doubleValue)
        }
        return cgInt
    }

    public func floatValue() -> CGFloat {
        var cgFloat: CGFloat = 0
        if let doubleValue = Double(self) {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
}
