//
//  VideoCollectionView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class VideoCollectionView: UICollectionView {
    let Videoslayout = VideosFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: Videoslayout)
        backgroundColor = .background
        register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class VideosFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        let w = UIScreen.main.bounds.width/2
        itemSize = CGSize(width: w-1, height: 130)
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
