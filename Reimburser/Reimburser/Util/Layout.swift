//
//  NavigationLayout.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/10/12.
//  Copyright © 2018 SwiftToolsKit. All rights reserved.
//

import UIKit

/// Navigation StatusBar SafeArea
class Layout {

    /// 获取 StatusBar frame
    public class func getStatusBarFrame() -> CGRect {
        return UIApplication.shared.statusBarFrame
    }

    /// 获取 NavigationBar frame
    public class func getNavigationBar() -> CGRect {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        return rootVC?.navigationController?.navigationBar.frame ?? CGRect.zero
    }

    /// 获取 NavigationBar frame
    public class func getTabBar() -> CGRect {
        return UITabBarController().tabBar.frame
    }

    /// 获取安全区
    public class func getSafeArea() -> UIEdgeInsets {
        let window = UIApplication.shared.keyWindow
        if #available(iOS 11.0, *) {
            let safeArea = window?.safeAreaInsets
            return safeArea ?? UIEdgeInsets.zero
        } else {
            return UIEdgeInsets.zero
        }
    }

    /// 获取安全区 顶部偏移量
    public class func getSafeAreaTop() -> CGFloat {
        guard #available(iOS 11.0, *) else {
            return getStatusBarFrame().height
        }
        let window = UIApplication.shared.keyWindow
        var topArea = window?.safeAreaInsets.top ?? CGFloat(0)
        topArea = topArea > CGFloat(0) ? topArea : getStatusBarFrame().height
        return topArea
    }

    ///
    /// isFixed = true

    /// NavigationBar 固定高度
    ///
    /// - Parameter isHidden: StatusBar 是否被隐藏， 默认没隐藏
    /// - Returns: 64 or 44
    public class func getNavigationBarHeight(andStatusBar isHidden: Bool = false) -> CGFloat {
        guard isHidden else {
            return 44.0
        }
        return 64.0
    }

    /// 获取 Navigation 高度
    ///
    /// - Parameter isFixed: 是否是固定高度，false：当 NavigationBar 隐藏时，NavigationBar 高度为0。 true：不管 NavigationBar 是否隐藏，都返回 NavigationBar 高度 44.0 。 默认为 true
    /// - Returns: 返回高度
    public class func getNavigationHeight(isFixed: Bool = true) -> CGFloat {
        guard isFixed else {
            return getSafeAreaTop() + getNavigationBar().height
        }
        return getSafeAreaTop() + getNavigationBarHeight()
    }

    /// 获取 tabbar 正确高度 ， 包含安全区底部高度 一同返回
    public class func getTabbarHeight() -> CGFloat {
        return Layout.getTabBar().height+Layout.getSafeArea().bottom
    }
}

extension Layout {
    public class var screen: CGRect {
        return UIScreen.main.bounds
    }
}
