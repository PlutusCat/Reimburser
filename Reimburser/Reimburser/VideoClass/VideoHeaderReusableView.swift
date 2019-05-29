//
//  VideoHeaderReusableView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/29.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class VideoHeaderReusableView: UICollectionReusableView {
    open class var id: String { return "VideoHeaderReusableView_ID" }
    
    private lazy var image: UIImageView = {
        let view = UIImageView(image: UIImage(named: "banner-Home"))
        view.backgroundColor = .gray04
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
