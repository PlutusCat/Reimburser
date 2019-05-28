//
//  ReimbursCollectionCell.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class ReimbursCollectionCell: UICollectionViewCell {
    open class var id: String { return "ReimbursCollectionCell_ID" }

    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.image = UIImage(named: "")
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red00
        contentView.addSubview(image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        image.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(2)
        }
    }
}
