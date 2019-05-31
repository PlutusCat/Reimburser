//
//  ImagePickerCell.swift
//  GXDImagePicker
//
//  Created by PlutusCat on 2017/10/13.
//  Copyright © 2017年 ImagePickerDemo. All rights reserved.
//

import UIKit

class ImagePickerCell: UITableViewCell {

    //相簿名称标签
    var titleLabel: UILabel!
    //照片数量标签
    var countLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .`default`
        selectedBackgroundView = UIView(frame: frame)
        
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)

        countLabel = UILabel()
        countLabel.textColor = .gray
        countLabel.numberOfLines = 1
        contentView.addSubview(countLabel)
    }

    func loadData(model: ImageAlbumItem) {

        titleLabel.text = model.albumTitle
        titleLabel.frame = CGRect(x: 20, y: 0, width: 100, height: 55)

        countLabel.text = "（\(model.fetchResult.count)）"
        countLabel.frame = CGRect(x: titleLabel.frame.maxX, y: 0, width: 500, height: 55)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
