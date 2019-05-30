//
//  SettingTableCell.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class SettingTableCell: UITableViewCell {
    open class var id: String { return "SettingTableCell_ID" }

    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "- TITLE -"
        label.font = .body
        label.textColor = .textBody
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var arrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_Arrow"))
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(title)
        contentView.addSubview(arrow)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: String) {
        title.text = model
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(16)
        }
        arrow.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 8, height: 12))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
}
