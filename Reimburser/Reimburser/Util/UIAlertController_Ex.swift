//
//  UIAlertController_Ex.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/29.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

extension UIAlertController {
    func actionSheet(_ title: String? = nil, titles: Array<String>, destructives: Array<Int>?, callBack: @escaping (_ index: Int) -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for i in 0 ..< titles.count {
            var style: UIAlertAction.Style = .`default`
            if let _ = destructives {
                if (destructives?.contains(i))! {
                    style = .destructive
                }
            }
            let itemAction = UIAlertAction(title: titles[i], style: style) { (action) in
                callBack(i)
            }
            alert.addAction(itemAction)
        }
        let cancelItem = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelItem)
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
