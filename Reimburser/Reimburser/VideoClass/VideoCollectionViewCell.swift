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
        view.backgroundColor = .blue01
        view.contentMode = .scaleAspectFit
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(model: Records) {
        image.setImage(string: model.cover)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        image.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        image.clipRectCorner(direction: .allCorners, cornerRadius: 8)
    }
}
