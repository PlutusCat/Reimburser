//
//  ReimbursViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import Alamofire
import Photos
import RealmSwift
import AssetsPickerViewController

class ReimbursViewController: BaseViewController {

    private var localmodel = [
        Reimbur(imgName: "icon_rent", title: "房租", ticketType: "102"),
        Reimbur(imgName: "icon_hydropower", title: "水电", ticketType: "101"),
        Reimbur(imgName: "icon_shoping", title: "网购", ticketType: ""),
        Reimbur(imgName: "icon_market", title: "超市", ticketType: ""),
        Reimbur(imgName: "icon_food", title: "吃饭", ticketType: ""),
        Reimbur(imgName: "icon_amusement", title: "娱乐", ticketType: ""),
        Reimbur(imgName: "icon_bus", title: "公交", ticketType: "103"),
        Reimbur(imgName: "icon_subway", title: "地铁", ticketType: "103"),
        Reimbur(imgName: "icon_Netcar", title: "网约车", ticketType: ""),
        Reimbur(imgName: "icon_express", title: "快递", ticketType: "104"),
        Reimbur(imgName: "icon_P", title: "停车", ticketType: "109"),
        Reimbur(imgName: "icon_cost", title: "话费", ticketType: "108"),
        Reimbur(imgName: "icon_other", title: "其他", ticketType: "123")
    ]

    private var model: Reimbur?
    
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
            make.top.equalTo(Layout.getNavigationHeight())
            make.left.right.equalToSuperview()
        }
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func uploadImgfile(imageData: Data, time: String) {
        
        view.makeToastActivity(.center)
        
        let device = "ios".data(using: .utf8)
        let createTime = time.data(using: .utf8)
        var ticketType = "".data(using: .utf8)
        if let type = model?.ticketType {
            ticketType = type.data(using: .utf8)
        }
        
        var headers: HTTPHeaders?
        let realm = try! Realm()
        if let loginManager = realm.object(ofType: LoginManagerRealm.self, forPrimaryKey: loginManagerRealmKey) {
            let token = loginManager.token
            headers = ["Planet-Access-Token": token]
        }
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData,
                                     withName: "file",
                                     fileName: time+"jpeg",
                                     mimeType: "image/jpeg")
            multipartFormData.append(createTime!, withName: "createTime")
            multipartFormData.append(device!, withName: "device")
            multipartFormData.append(ticketType!, withName: "ticketType")
        }, to: API.credentialUpload, headers: headers, encodingCompletion: { (request) in
            switch request {
            case .success(let request, _, _):
                request.uploadProgress(closure: { (progress) in
                    printm("progress =", progress)
                })
                request.validate()
                request.responseJSON(completionHandler: { (DResponse) in
                    printm(DResponse.result)
                    if DResponse.result.isSuccess {
                        printm("上传成功！！！")
                        self.view.toTitleToast(message: "上传完成,稍后会有通知提醒您红包获取情况")
                    }
                    if DResponse.result.isFailure {
                        printm("上传失败！！！", DResponse.result.error ?? "未知错误")
                        self.view.showError(message: "上传失败，请稍候重试")
                    }
                })
                break
            case .failure(_):
                printm("上传失败！！！")
                self.view.showError(message: "上传失败，请稍候重试")
                break
            }
        })
        
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
        
        printm("indexPath.row =", indexPath.row)
        model = localmodel[indexPath.row]

        UIAlertController().actionSheet("上传发票照片", titles: ["拍照", "相册"], destructives: nil, callBack: { (index) in
            switch index {
            case 0:
                let vc = CameraViewController.viewController { (image) in
                    let date = Date().milliStamp
                    if let imageData = image.jpegData(compressionQuality: 1.0) {
                        self.uploadImgfile(imageData: imageData, time: date)
                    }
                }
                self.present(vc, animated: true) {
                    printm("**** 弹出相机界面 ****")
                }
            case 1:
                let pickerConfig = AssetsPickerConfig()
                
                let picker = AssetsPickerViewController()
                picker.pickerConfig = pickerConfig
                picker.pickerDelegate = self
                self.present(picker, animated: true) {
                    printm("**** 弹出相册界面 ****")
                }
            default:
                break
            }
        })
    }
}

extension ReimbursViewController: AssetsPickerViewControllerDelegate {
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        if let asset = assets.first {
            let imageManager = PHCachingImageManager()
            imageManager.requestImageData(for: asset, options: nil) { (imgData, info, orientation, nil) in
                printm("localIdentifier = ", asset.localIdentifier)
                var date = ""
                if let creationDate = asset.creationDate {
                    date = creationDate.milliStamp
                }
                if let imgData = imgData {
                    self.uploadImgfile(imageData: imgData, time: date)
                }
            }
        }
    }
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        if controller.selectedAssets.count > 0 {
            controller.photoViewController.deselectAll()
        }
        return true
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
        label.font = UIFont.callout
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
