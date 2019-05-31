//
//  ImagePickerController.swift
//  GXDImagePicker
//
//  Created by PlutusCat on 2017/10/13.
//  Copyright © 2017年 ImagePickerDemo. All rights reserved.
//

import UIKit
import Photos

struct ImageAlbumItem {
    /// 相簿名称
    var albumTitle: String?
    /// 相簿内的资源
    var fetchResult: PHFetchResult<PHAsset>
}

class ImagePickerController: UIViewController {

    var albumTableView: UITableView!
    var items: [ImageAlbumItem] = []
    /// 最大选择数，默认9张
    var maxSelected: Int = Int.max
    /// 选择完成回调
    var completeHandler:((_ assets: [PHAsset])->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "照片"
        view.backgroundColor = .white

        let leftItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(leftItemAction))
        navigationItem.leftBarButtonItem = leftItem

        createSubviews()
        getFetvhOpiton()
    }

    func createSubviews() {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        albumTableView = UITableView(frame: frame, style: .plain)
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.register(ImagePickerCell.self, forCellReuseIdentifier: "ImagePickerCell")
        view.addSubview(albumTableView)
    }

    func getFetvhOpiton() {
        //权限
        PHPhotoLibrary.requestAuthorization({ (status) in
            if status != .authorized {
                return
            }

            // 列出所有系统的相册
            let smartOptions = PHFetchOptions()
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum,
                                                                      subtype: .albumRegular,
                                                                      options: smartOptions)
            self.convertCollection(collection: smartAlbums)

            //列出所有用户创建的相册
            let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
            self.convertCollection(collection: userCollections
                as! PHFetchResult<PHAssetCollection>)

            //相册按包含的照片数量排序（降序）
            self.items.sort { (item1, item2) -> Bool in
                return item1.fetchResult.count > item2.fetchResult.count
            }

            DispatchQueue.main.async{
                self.albumTableView?.reloadData()

                //首次进来后直接进入第一个相册图片展示页面（相机胶卷）
                let imageCollectionVC = ImageCollectionController()
                imageCollectionVC.title = self.items.first?.albumTitle
                imageCollectionVC.assetsFetchResults = self.items.first?.fetchResult
                imageCollectionVC.completeHandler = self.completeHandler
                imageCollectionVC.maxSelected = self.maxSelected
                self.navigationController?.pushViewController(imageCollectionVC, animated: false)

            }
        })
    }

    @objc func leftItemAction() {

        dismiss(animated: true, completion: nil)

    }


    func convertCollection(collection: PHFetchResult<PHAssetCollection>) {

        for i in 0..<collection.count {
            let resultOptions = PHFetchOptions()
            resultOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                              ascending: false)]
            resultOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                  PHAssetMediaType.image.rawValue)
            let item = collection[i]
            let assetsFetchResult = PHAsset.fetchAssets(in: item, options: resultOptions)

            if assetsFetchResult.count > 0 {
                let title = titleOfAlbumForChinse(title: item.localizedTitle)
                items.append(ImageAlbumItem(albumTitle: title,
                                            fetchResult: assetsFetchResult))
            }
        }

    }

    func titleOfAlbumForChinse(title: String?) -> String? {

        guard title != nil else { return nil }

        var result = String()

        switch title! {
        case "Slo-mo":
            result = "慢动作"
        case "Recently Added":
            result = "最近添加"
        case "Favorites":
            result = "个人收藏"
        case "Recently Deleted":
            result = "最近删除"
        case "Videos":
            result = "视频"
        case "All Photos":
            result = "所有照片"
        case "Selfies":
            result = "自拍"
        case "Screenshots":
            result = "屏幕快照"
        case "Camera Roll":
            result = "相机胶卷"
        default:
            result = title!
        }

        return result

    }

    func perpareCustom(cell: ImagePickerCell?) {

        let imageCollectionVC = ImageCollectionController()
        imageCollectionVC.completeHandler = completeHandler
        imageCollectionVC.title = cell?.titleLabel.text
        imageCollectionVC.maxSelected = maxSelected
        guard let indexPath = albumTableView.indexPath(for: cell!) else { return }
        imageCollectionVC.assetsFetchResults = items[indexPath.row].fetchResult

        navigationController?.pushViewController(imageCollectionVC, animated: true)
    }


//    func isPresentEnter() -> Bool {
//        guard presentingViewController == nil  else { return false }
//        do { return false }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("deinit == ImagePickerController")
    }

}

extension ImagePickerController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagePickerCell", for: indexPath)
            as! ImagePickerCell
        cell.loadData(model: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cell = tableView.cellForRow(at: indexPath) as! ImagePickerCell
        perpareCustom(cell: cell)

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}

extension UIViewController {
    @discardableResult
    func presentImagePicker(maxSelected:Int = 9, completeHandler:((_ assets:[PHAsset])->())?) -> ImagePickerController? {

            let vc = ImagePickerController()
            vc.completeHandler = completeHandler
            vc.maxSelected = maxSelected
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
            return vc
    }
}

