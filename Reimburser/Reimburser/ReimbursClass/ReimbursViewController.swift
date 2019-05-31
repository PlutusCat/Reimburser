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
import AssetsPickerViewController

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
        Reimbur(imgName: "icon_cost", title: "话费"),
        Reimbur(imgName: "icon_cost", title: "其他")
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
            make.top.equalTo(Layout.getNavigationHeight())
            make.left.right.equalToSuperview()
        }
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func uploadImgfile(imageData: Data, time: String) {
        
        let device = "ios".data(using: .utf8)
        let createTime = time.data(using: .utf8)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData,
                                     withName: "file",
                                     fileName: time+"jpeg",
                                     mimeType: "image/jpeg")
            multipartFormData.append(createTime!, withName: "createTime")
            multipartFormData.append(device!, withName: "device")
        }, to: API.credentialUpload, encodingCompletion: { (request) in
            switch request {
            case .success(let request, _, _):
                //   printm(streamFileURL!,request,streamingFromDisk)
                request.responseJSON(completionHandler: { (DResponse) in
                    if DResponse.result.isSuccess {
                        printm("上传成功！！！")
                    }
                })
                break
            case .failure(_):
                printm("上传失败！！！")
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
        UIAlertController().actionSheet("上传发票照片", titles: ["拍照", "相册"], destructives: nil, callBack: { (index) in
            switch index {
            case 0:
                let vc = CameraViewController.viewController { (image) in
                    
                    let date = Date().milliStamp
                    
                    if let imageData = image.jpegData(compressionQuality: 1.0) {
                        self.uploadImgfile(imageData: imageData, time: date)
                    }
                        /// 保存当前获取到的图片到沙盒 临时文件存储路径 tmp/
//                    let fullName = date+".jpeg"
//                        let tmp = NSTemporaryDirectory()
//                        let fullPath = tmp.appending(fullName)
//                        try? imageData.write(to: URL(fileURLWithPath: fullPath))
//                        let fileManager = FileManager.default
//                        let exist = fileManager.fileExists(atPath: fullPath)
//                        if exist {
//                            Alamofire.upload(URL(fileURLWithPath: fullPath), to: API.credentialUpload).validate().responseData { (DDataRequest) in
//                                if DDataRequest.result.isSuccess {
//                                    printm(String.init(data: DDataRequest.data!, encoding: String.Encoding.utf8)!)
//                                }
//                                if DDataRequest.result.isFailure {
//                                    printm("上传失败！！！")
//                                }
//                            }
//
//                        } else {
//
//                        }
                        
//                    }
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
                let date = Date().milliStamp
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
