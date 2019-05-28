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

class VideoViewController: BaseViewController {

    private var model: VideosRealm?
    private let player: IJKFFMoviePlayerController = {
        let ijkView = IJKFFMoviePlayerController()
        return ijkView
    }()

    private lazy var collection: VideoCollectionView = {
        let view = VideoCollectionView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "视频"
        view.addSubview(collection)
        getVideoList()
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
                self.collection.reloadData()
//               self.view.toastShow(type: .success)
            }
        }) { (error) in
            
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let records = model?.data?.records {
            return records.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.id, for: indexPath) as! VideoCollectionViewCell
        if let records = model?.data?.records {
            cell.set(model: records[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}
