//
//  ImageCollectionCell.swift
//  GXDImagePicker
//
//  Created by PlutusCat on 2017/10/13.
//  Copyright © 2017年 ImagePickerDemo. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    //显示缩略图
    var imageView: UIImageView!

    //显示选中状态的图标
    var selectedIcon: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)

        selectedIcon = UIImageView(image: UIImage(named: "Icon_Default"))
        selectedIcon.contentMode = .scaleAspectFit
        contentView.addSubview(selectedIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height)
        selectedIcon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    }

    func playAnimate() {

        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: .allowUserInteraction, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2,
                               animations: {
                                self.selectedIcon.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4,
                               animations: {
                                self.selectedIcon.transform = CGAffineTransform.identity
            })
        }, completion: nil)
    }
    
    open override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedIcon.image = UIImage(named: "Icon_Selected")
            }else {
                selectedIcon.image = UIImage(named: "Icon_Default")
            }
        }
    }

}
