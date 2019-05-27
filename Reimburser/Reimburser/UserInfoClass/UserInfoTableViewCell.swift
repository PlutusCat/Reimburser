//
//  UserInfoTableViewCell.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import SnapKit

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

    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        title.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(8)
        }
        arrow.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
}
