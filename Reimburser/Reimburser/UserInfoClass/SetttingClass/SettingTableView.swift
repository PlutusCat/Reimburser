//
//  SettingTableView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class SettingTableView: BaseTableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        showsVerticalScrollIndicator = false
        backgroundColor = .background
        sectionHeaderHeight = 8
        sectionFooterHeight = 1
        register(SettingTableCell.self, forCellReuseIdentifier: SettingTableCell.id)
        addFooter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


class SettingHeader: UIView {
    
    private lazy var headerIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "icon"))
        return icon
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .caption02
        label.text = SystemManager.getVersion()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBack
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubview(headerIcon)
        addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 71, height: 62))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        title.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerIcon.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
}
