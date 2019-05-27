//
//  UIDevice+Extension.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/3/28.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import Foundation

extension UIDevice {

    /// 是否是流海屏
    ///
    /// - Returns: true or false
    public class var isFlowingseaScreen: Bool {
        if Layout.getSafeAreaTop() > 20 {
            return true
        } else {
            return false
        }
    }

    /// 是否是 iPhone
    ///
    /// - Returns: true or false
    /// 主色调
    public class var isPhone: Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return true
        default:
            return false
        }
    }
    /// 是否是 iPhone
    ///
    /// - Returns: true or false
    public class var isPad: Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return true
        default:
            return false
        }
    }
}
