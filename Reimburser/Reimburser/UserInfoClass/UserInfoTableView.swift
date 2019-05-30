//
//  UserInfoTableView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class UserInfoTableView: BaseTableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        showsVerticalScrollIndicator = false
        backgroundColor = .background
        sectionHeaderHeight = 8
        sectionFooterHeight = 1
        register(UserInfoTableViewCell.self, forCellReuseIdentifier: UserInfoTableViewCell.id)
        addFooter()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class UserInfoHeader: UIView {

    var tapGestureBack: (() -> Void)?
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "请点此登陆"
        label.font = .title01
        label.numberOfLines = 1
        label.textColor = .textBack
        label.backgroundColor = .white
        return label
    }()
    lazy var headerIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "icon_Username"))
        return icon
    }()
    private lazy var backView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubview(backView)
        backView.addSubview(headerIcon)
        backView.addSubview(title)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        addGestureRecognizer(tapGesture)
    }

    @objc private func tapGestureAction() {
        if let cell = tapGestureBack {
            cell()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
        }
        headerIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        title.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(headerIcon.snp.right).offset(16)
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        let radius = headerIcon.frame.size.width*0.5
        headerIcon.clipRectCorner(direction: .allCorners, cornerRadius: radius)
    }
}
