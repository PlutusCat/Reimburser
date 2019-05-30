//
//  BottomToolsView.swift
//  CameraKit
//
//  Created by PlutusCat on 2018/12/25.
//  Copyright © 2018 CameraKit. All rights reserved.
//

import UIKit
import SnapKit

class BottomToolsView: UIView {

    var cameraShutterBlock:(() -> ())!

    private var cameraShutter: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "CameraShutter_icon"), for: .normal)
        button.setImage(UIImage(named: "CameraShutter_icon_selected"), for: .highlighted)
        button.addTarget(self, action: #selector(cameraShutterAction), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        addSubview(cameraShutter)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        cameraShutter.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }

        snp.makeConstraints { (make) in
            make.height.equalTo(100+SafeLayout.getSafeArea().bottom)
        }
    }

    @objc private func cameraShutterAction() {
        if let call = cameraShutterBlock {
            call()
        }
    }
}


// MARK: 获取安全区尺寸
class SafeLayout {

    /// 获取 StatusBar frame
    public class func getStatusBarFrame() -> CGRect {
        return UIApplication.shared.statusBarFrame
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
        var top = window?.safeAreaInsets.top ?? CGFloat(0)
        top = top > CGFloat(0) ? top : getStatusBarFrame().height
        return top
    }

}

class NotificationName {
    static let cameraFinish = NSNotification.Name(rawValue: "CameraFinishNotication")
}
