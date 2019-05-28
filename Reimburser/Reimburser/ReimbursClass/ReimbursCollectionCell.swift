//
//  ReimbursCollectionCell.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class Reimbur {
    var imageName: String
    var title: String
    init(imgName: String, title: String) {
        self.imageName = imgName
        self.title = title
    }
}
class ReimbursCollectionCell: UICollectionViewCell {
    open class var id: String { return "ReimbursCollectionCell_ID" }

    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.body
        label.textColor = UIColor.textBody
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(image)
        contentView.addSubview(title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setModel(model: Reimbur) {
        image.image = UIImage(named: model.imageName)
        title.text = model.title
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        image.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalToSuperview()
        }
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}
