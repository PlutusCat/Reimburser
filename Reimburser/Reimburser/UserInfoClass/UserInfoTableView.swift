//
//  UserInfoTableView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class UserInfoTableView: UITableView {

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

    private func addFooter() {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: Layout.getSafeArea().bottom))
        tableFooterView = view
    }
    
}

class UserInfoHeader: UIView {

    var tapGestureBack: (() -> Void)?
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "请登陆"
        label.font = .title01
        label.numberOfLines = 1
        label.textColor = .textBack
        label.backgroundColor = .white
        return label
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
        title.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
    }
}
