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
    
    override init() {
        super.init()
        let w = UIScreen.main.bounds.width/4
        itemSize = CGSize(width: w-3, height: 130)
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        scrollDirection = .vertical
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
