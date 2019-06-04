//
//  VideoViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import ViewAnimator
import SnapKit
import Alamofire
import SwiftyJSON
import RealmSwift

private enum RequestState {
    case getting
    case getend
    case moreing
    case moreend
}

class VideoViewController: UICollectionViewController {

    private var records: List<Records>?
    private var animations = [Animation]()
    private var pageNumber = 1
    private var pageSize = 20
    /// 有更多数据,可以加载更多
    private var isMore = false
    private var requestState: RequestState?
    
    private lazy var headerView: VideoHeaderView = {
        let view = VideoHeaderView()
        return view
    }()

    private var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshAction), for: UIControl.Event.valueChanged)
        return control
    }()

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
        collectionView.refreshControl = refreshControl
        view.addSubview(headerView)
        getVideoList()
        
    }

    @objc func refreshAction(_ sender: UIRefreshControl) {
        getVideoList()
    }

    func reload() {
        collectionView.reloadData()
        collectionView.performBatchUpdates({
            UIView.animate(views: collectionView.orderedVisibleCells, animations: animations)
        }, completion: nil)
    }

    func insertItems(at indexPaths: [IndexPath]) {
        self.collectionView.insertItems(at: indexPaths)
        self.collectionView.performBatchUpdates({
            if let lastCell = self.collectionView.orderedVisibleCells.last {
                UIView.animate(views: [lastCell], animations: self.animations)
            }
        }, completion: nil)
    }

    @objc func add() {
        view.toastDiss()
    }

    private func getVideoList() {
        self.isMore = false
        requestState = .getting
        let paramet: Parameters = ["current": 1,
                                   "size": pageSize,
                                   "label": []]
        NetworkManager.request(URLString: API.videoList, paramet: paramet, token: false, finishedCallback: { (result) in
            let json = JSON(result)
            let model = VideosRealm.from(json: json.dictionaryValue)
            DispatchQueue.main.async {
                if let data = model.data {
                    self.records = data.records
                    self.pageNumber = 2
                    self.reload()
                    if let recordsCount = data.records?.count {
                        if recordsCount < self.pageSize {
                            self.isMore = false
                        } else {
                            self.isMore = true
                        }
                    }
                } else {
                    printm("没有获取到 data 数据")
                    self.isMore = false
                }
                self.refreshControl.endRefreshing()
                self.requestState = .getend
            }
        }) { (error) in
            self.refreshControl.endRefreshing()
            self.isMore = false
            self.requestState = .getend
            printm("网络出现错误")
        }
    }

    private func getMoreVideoList() {

//        switch requestState {
//        case .getting?, .moreing?:
//            return
//        default:
//            break
//        }
//        guard isMore else {
//            printm("没有更多了!!")
//            return
//        }
        requestState = .moreing
        let paramet: Parameters = ["current": pageNumber,
                                   "size": pageSize,
                                   "label": []]
        NetworkManager.request(URLString: API.videoList, paramet: paramet, token: false, finishedCallback: { (result) in
            let json = JSON(result)
            let model = VideosRealm.from(json: json.dictionaryValue)
            DispatchQueue.main.async {
                if let records = model.data?.records {
                    if records.count < self.pageSize {
                        self.isMore = false
                    }
                    self.pageNumber += 1
                    let resultSize = self.records?.count ?? 0
                    var indexPaths = [IndexPath]()
                    autoreleasepool{
                        for i in 0..<records.count {
                            let endIndex = resultSize + i
                            let item = records[i]
                            self.records?.insert(item, at: endIndex)
                            let indexPath = IndexPath(item: endIndex,
                                                      section: 0)
                            indexPaths.append(indexPath)
                        }
                    }
                    self.insertItems(at: indexPaths)
                } else {
                    printm("没有获取到更多 data 数据")
                }
                self.requestState = .moreend
            }
        }) { (error) in
            printm("网络出现错误")
            self.requestState = .moreend
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(Layout.getNavigationHeight())
            make.left.right.equalToSuperview()
        }
    }
    
}

extension VideoViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let records = records {
            return records.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.id, for: indexPath) as! VideoCollectionViewCell
        if let records = records {
            cell.set(model: records[indexPath.item])
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let count = records?.count {
            printm("indexPath = ", indexPath)
            printm("records?.count = ", count)
            if indexPath.row == count-1 {
                getMoreVideoList()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let model = records?[indexPath.row] {
            let vc = VideoPlayerController()
            vc.videoUrl = model.url
            present(vc, animated: true, completion: nil)
        }
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

class LoadMoreFooter: UIView {
    private lazy var loadMore: UIButton = {
        let button = UIButton()
        button.setTitle("加载更多...", for: UIControl.State.normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red00
        addSubview(loadMore)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        loadMore.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
