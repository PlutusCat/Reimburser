//
//  ToastView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/23.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import SnapKit
import ViewAnimator

public enum ToastType {
    case success
    case error
    case unknow
}

class ToastView: UIView {
    let animations = [AnimationType.from(direction: .bottom, offset: 40),
                      AnimationType.zoom(scale: 0.96)]
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "这里是标题"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.yellow00
        return imageView
    }()

    init(type: ToastType) {
        let Y = Layout.screen.height-Layout.getTabbarHeight()-60
        super.init(frame: CGRect(x: 0,
                                 y: Y,
                                 width: 200,
                                 height: 50))
        var color: UIColor
        switch type {
        case .success:
            color = UIColor.green00
        case .error:
            color = UIColor.red00
        default:
            color = UIColor.yellow00
        }
        layer.borderWidth = 2.0
        layer.borderColor = color.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .white
        addSubview(icon)
        addSubview(title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalToSuperview().offset(8)
            make.centerY.equalTo(title)
        }
        title.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(icon.snp.right)
        }
    }
}

extension UIView {
    func searchToast() -> ToastView? {
        var array = [ToastView]()
        for item in self.subviews.enumerated() {
            if item.element.isKind(of: ToastView.self) {
                array.append(item.element as! ToastView)
            }
        }
        if let root = UIApplication.shared.keyWindow {
            for item in root.subviews.enumerated() {
                if item.element.isKind(of: ToastView.self) {
                    array.append(item.element as! ToastView)
                }
            }
        }
        if array.count > 1 {
            for i in 0..<array.count-1 {
                array[i].removeFromSuperview()
            }
            return array.last
        }
        return array.last
    }
    public func toastShow(type: ToastType) {
        self.toastDiss()
        let toast = ToastView(type: type)
        toast.centerX = self.centerX
        self.addSubview(toast)
        UIView.animate(views: [toast],
                       animations: toast.animations,
                       delay: 0.1)
    }
    public func toastDiss() {
        if let toast = self.searchToast() {
            UIView.animate(views: [toast],
                           animations: toast.animations,
                           reversed: true,
                           initialAlpha: 1.0,
                           finalAlpha: 0.0,
                           completion: {
                            toast.removeFromSuperview()
            })
        }
    }
    public func toastOnWindow(type: ToastType) {
        self.toastDiss()
        if let window = UIApplication.shared.keyWindow {
            let toast = ToastView(type: type)
            toast.centerX = window.centerX
            window.addSubview(toast)
            UIView.animate(views: [toast],
                           animations: toast.animations,
                           delay: 0.1)
        }
    }
}
