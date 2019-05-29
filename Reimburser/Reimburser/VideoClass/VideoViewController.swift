//
//  VideoViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import ViewAnimator
import IJKMediaFramework
import SnapKit
import Alamofire
import SwiftyJSON

class VideoViewController: UICollectionViewController {

    private var model: VideosRealm?
    private let player: IJKFFMoviePlayerController = {
        let ijkView = IJKFFMoviePlayerController()
        return ijkView
    }()
    
    private lazy var headerView: VideoHeaderView = {
        let view = VideoHeaderView()
        return view
    }()
    
    private var animations = [Animation]()
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        let zoomAn = AnimationType.zoom(scale: 0.95)
        let fromAn = AnimationType.from(direction: .bottom, offset: 10.0)
        animations.append(zoomAn)
        animations.append(fromAn)
        collectionView.backgroundColor = .background
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.id)
        collectionView.register(VideoHeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: VideoHeaderReusableView.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        navigationItem.title = "首页"
        view.addSubview(headerView)
        getVideoList()
    }

    func reload() {
        collectionView.reloadData()
        collectionView.performBatchUpdates({
            UIView.animate(views: collectionView.orderedVisibleCells, animations: animations)
        }, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    @objc func add() {
        view.toastDiss()
    }

    private func getVideoList() {
        let paramet: Parameters = ["current": 1,
                                   "size": 10,
                                   "label": []]
        NetworkManager.request(URLString: API.videoList, paramet: paramet, finishedCallback: { (result) in
            let json = JSON(result)
            let model = VideosRealm.from(json: json.dictionaryValue)
            DispatchQueue.main.async {
                self.model = model
                self.reload()
            }
        }) { (error) in
            
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(Layout.getNavigationBarHeight())
            make.left.right.equalToSuperview()
        }
    }
}

extension VideoViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let records = model?.data?.records {
            return records.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.id, for: indexPath) as! VideoCollectionViewCell
        if let records = model?.data?.records {
            cell.set(model: records[indexPath.item])
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

class VideosFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        itemSize = CGSize(width: UIScreen.main.bounds.width/2, height: 200)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoHeaderView: UIView {
    lazy var banner: UIImageView = {
        let image = UIImageView(image: UIImage(named: "banner-Home"))
        return image
    }()

    lazy var titleIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "tab"))
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(banner)
        addSubview(titleIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        banner.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(Layout.screen.width*0.44)
        }
        titleIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(banner.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 114, height: 15))
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
