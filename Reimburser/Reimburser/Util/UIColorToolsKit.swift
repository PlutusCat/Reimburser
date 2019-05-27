//
//  UIColorToolsKit.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/6/8.
//  Copyright © 2018年 SwiftToolsKit. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }

    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff,
                  green: (hex >> 8) & 0xff,
                  blue: hex & 0xff)
    }

    /// 主色调
    open class var main: UIColor { return UIColor(hex: "#F6572D")}
    /// 背景色 eeeeee 243
    open class var background: UIColor { return UIColor(hex: "#f1f1f1")}
//    open class var background: UIColor {
//        return UIColor(red: 243, green: 243, blue: 243)
//    }
    /// 文字黑
    open class var textBack: UIColor { return UIColor(hex: "#2A2A2A")}
    /// body 灰
    open class var textBody: UIColor { return UIColor(hex: "#4D4D4D")}
    ///文字灰 #999999
    open class var textGray: UIColor { return UIColor(hex: "#999999")}
    /// 灰度 深 00 - 04 浅
    open class var gray00: UIColor { return UIColor(hex: "#04040F").withAlphaComponent(0.45) }
    /// 灰度 深 00 - 04 浅
    open class var gray01: UIColor { return UIColor(hex: "#000019").withAlphaComponent(0.22) }
    /// 灰度 深 00 - 04 浅
    open class var gray02: UIColor { return UIColor(hex: "#191964").withAlphaComponent(0.18) }
    /// 灰度 深 00 - 04 浅
    open class var gray03: UIColor { return UIColor(hex: "#191964").withAlphaComponent(0.07) }
    /// 灰度 深 00 - 04 浅
    open class var gray04: UIColor { return UIColor(hex: "#0A0A78").withAlphaComponent(0.05) }

    /// 蓝色 深 00 - 02 浅
    open class var blue00: UIColor { return UIColor(hex: "#5AC8FA") }
    /// 蓝色 深 00 - 02 浅
    open class var blue01: UIColor { return UIColor(hex: "#007AFF") }
    /// 蓝色 深 00 - 02 浅
    open class var blue02: UIColor { return UIColor(hex: "#5856D6") }

    /// 红色 深
    open class var red00: UIColor { return UIColor(hex: "#FF3B30") }
    /// 红色 浅
    open class var red01: UIColor { return UIColor(hex: "#FF2D55") }

    /// 黄色 深
    open class var yellow00: UIColor { return UIColor(hex: "#FF9500") }
    /// 黄色 浅
    open class var yellow01: UIColor { return UIColor(hex: "#ffcc00") }

    /// 绿色
    open class var green00: UIColor { return UIColor(hex: "#4CD964") }

    /// 十六进制字符串 转 Color
    ///
    /// - Parameter hex: 十六进制字符串
    public convenience init(hex: String) {

        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex: String = hex

        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch hex.count {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:

                let error = """
                            Invalid RGB string, number of characters after '#'
                            should be either 3, 4, 6 or 8", terminator:
                            """
                printm(error)
            }
        } else {
            printm("Scan hex error")
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}
