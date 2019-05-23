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
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "这里是标题"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
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
            make.left.equalToSuperview()
            make.centerY.equalTo(title)
        }
        title.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(icon.snp.right)
        }
    }
}

extension UIView {
    public func toastShow(type: ToastType) {
        for item in self.subviews.enumerated() {
            if item.element.isKind(of: ToastView.self) {
                self.toastDiss()
            }
        }
        let toast = ToastView(type: type)
        toast.centerX = self.centerX
        self.addSubview(toast)
        let from = AnimationType.from(direction: .bottom, offset: 20)
        UIView.animate(views: [toast], animations: [from])
    }
    public func toastDiss() {
        for item in self.subviews.enumerated() {
            if item.element.isKind(of: ToastView.self) {
                let from = AnimationType.from(direction: .bottom, offset: 20)
                UIView.animate(views: [item.element],
                               animations: [from],
                               reversed: true,
                               initialAlpha: 1.0,
                               finalAlpha: 0.0,
                               completion: {
                    item.element.removeFromSuperview()
                })
            }
        }
    }
}
