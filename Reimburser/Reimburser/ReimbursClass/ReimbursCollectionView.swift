//
//  ReimbursCollectionView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class ReimbursCollectionView: UICollectionView {

    let reimburslayout = ReimbursFlowLayout()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: reimburslayout)
        backgroundColor = .background
        register(ReimbursCollectionCell.self, forCellWithReuseIdentifier: ReimbursCollectionCell.id)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class ReimbursFlowLayout: UICollectionViewFlowLayout {
    /// 间距
    let columns = 5
    override init() {
        super.init()
        let w = UIScreen.main.bounds.width/5
        itemSize = CGSize(width: w, height: w)

        scrollDirection = .vertical
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
