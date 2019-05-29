//
//  ReimbursViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class ReimbursViewController: BaseViewController {

    private var localmodel = [
        Reimbur(imgName: "icon_rent", title: "房租"),
        Reimbur(imgName: "icon_hydropower", title: "水电"),
        Reimbur(imgName: "icon_shoping", title: "网购"),
        Reimbur(imgName: "icon_market", title: "超市"),
        Reimbur(imgName: "icon_food", title: "吃饭"),
        Reimbur(imgName: "icon_amusement", title: "娱乐"),
        Reimbur(imgName: "icon_bus", title: "公交"),
        Reimbur(imgName: "icon_subway", title: "地铁"),
        Reimbur(imgName: "icon_Netcar", title: "网约车"),
        Reimbur(imgName: "icon_express", title: "快递"),
        Reimbur(imgName: "icon_P", title: "停车"),
        Reimbur(imgName: "icon_cost", title: "话费")
    ]

    private lazy var headerView: ReimbursHeader = {
        let view = ReimbursHeader()
        return view
    }()

    private lazy var collection: ReimbursCollectionView = {
        let view = ReimbursCollectionView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "报销"
        view.addSubview(headerView)
        view.addSubview(collection)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(Layout.getNavigationBarHeight())
            make.left.right.equalToSuperview()
        }
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension ReimbursViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localmodel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReimbursCollectionCell.id, for: indexPath) as! ReimbursCollectionCell
        cell.setModel(model: localmodel[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        UIAlertController().actionSheet("上传发票照片", titles: ["拍照", "相册"], destructives: nil, callBack: { (index) in
            switch index {
            case 0:
                printm("拍照")
            case 1:
                printm("相册选取")
            default:
                break
            }
        })
    }
}

class ReimbursHeader: UIView {
    lazy var banner: UIImageView = {
        let image = UIImageView(image: UIImage(named: "banner"))
        return image
    }()

    lazy var adIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "icon_qmbx"))
        return image
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "上传票据种类"
        label.font = UIFont.title03
        label.textColor = UIColor.textBack
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(banner)
        addSubview(adIcon)
        addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        banner.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(Layout.screen.width*0.24)
        }
        adIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 40))
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(banner.snp.bottom).offset(16)
        }
        title.snp.makeConstraints { (make) in
            make.left.equalTo(adIcon)
            make.top.equalTo(adIcon.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
