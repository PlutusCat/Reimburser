//
//  VideoCollectionViewCell.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/28.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {
    open class var id: String { return "VideoCollectionViewCell_ID" }

    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray04
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var redEnvelope: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_wallet"))
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var browse: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_eye"))
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var browseLabel: UILabel = {
        let label = UILabel()
        label.font = .caption02
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .subHead
        label.textColor = .textBody
        label.numberOfLines = 1
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(redEnvelope)
        contentView.addSubview(browse)
        contentView.addSubview(browseLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(model: Records) {
        image.setImage(string: model.cover)
        title.text = model.title
        browseLabel.text = model.playVolume
        if model.watched == "true" {
            redEnvelope.isHidden = true
        } else {
            redEnvelope.isHidden = false
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        image.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview().inset(4)
            make.height.equalTo(146)
        }
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.left.right.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
        }
        redEnvelope.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 33))
            make.right.bottom.equalTo(image).inset(6)
        }
        browse.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 10, height: 6))
            make.left.bottom.equalTo(image).inset(6)
        }
        browseLabel.snp.makeConstraints { (make) in
            make.left.equalTo(browse.snp.right).offset(4)
            make.centerY.equalTo(browse)
        }
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        image.clipRectCorner(direction: .allCorners, cornerRadius: 8)
    }
}
