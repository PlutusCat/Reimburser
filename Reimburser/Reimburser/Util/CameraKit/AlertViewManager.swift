//
//  AlertViewManager.swift
//  CameraKit
//
//  Created by PlutusCat on 2018/12/24.
//  Copyright © 2018 CameraKit. All rights reserved.
//

import UIKit

class AlertViewManager: UIAlertController {

    /// 默认 取消 确定 模式
    /// - title           : 标题
    /// - mesStr          : 详细内容
    /// - continueStr     : 确定按钮 文字标题
    /// - continueHandler : 确定按钮回调
    class func alertDefault(title: String, mesStr: String, continueStr: String, handler: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: mesStr, preferredStyle: .alert)
        let cancelItem = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let continueItem = UIAlertAction(title: continueStr, style: .`default`) { (action) in
            handler()
        }

        alert.addAction(cancelItem)
        alert.addAction(continueItem)

        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
