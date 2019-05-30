//
//  UserInfoTableViewCell.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import SnapKit

class Setitem {
    var icon: String
    var title: String
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
}

class UserInfoTableViewCell: UITableViewCell {

    open class var id: String { return "UserInfoTableViewCell_ID" }

    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "- TITLE -"
        label.font = .body
        label.textColor = .textBody
        label.numberOfLines = 0
        return label
    }()

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_market")
        return imageView
    }()

    private lazy var arrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_Arrow"))
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(arrow)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(model: Setitem) {
        icon.image = UIImage(named: model.icon)
        title.text = model.title
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        title.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(16)
        }
        arrow.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 8, height: 12))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
}
