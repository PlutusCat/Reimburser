//
//  ImageCollectionController.swift
//  GXDImagePicker
//
//  Created by PlutusCat on 2017/10/13.
//  Copyright © 2017年 ImagePickerDemo. All rights reserved.
//

import UIKit
import Photos

class ImageCollectionController: UIViewController {

    var collectionView: UICollectionView!
    var toolBar: UIToolbar!

    ///取得的资源结果，用了存放的PHAsset
    var assetsFetchResults: PHFetchResult<PHAsset>?

    ///带缓存的图片管理对象
    var imageManager:PHCachingImageManager!

    ///缩略图大小
    var assetGridThumbnailSize:CGSize!

    ///每次最多可选择的照片数量
    var maxSelected:Int = Int.max

    ///完成按钮
    var completeButton: ImageCompleteButton!
    ///照片选择完毕后的回调
    var completeHandler:((_ assets:[PHAsset])->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        automaticallyAdjustsScrollViewInsets = true

        let rightItem = UIBarButtonItem(title: "取消", style: .plain,
                                        target: self, action: #selector(rightItemAction))
        navigationItem.rightBarButtonItem = rightItem

        createSubviews()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let scale = UIScreen.main.scale
        let cellSize = (collectionView.collectionViewLayout as!
            UICollectionViewFlowLayout).itemSize
        assetGridThumbnailSize = CGSize(width: cellSize.width*scale ,
                                        height: cellSize.height*scale)

    }

    func createSubviews() {

        let screenWidth = view.bounds.size.width
        let screenHeight = view.bounds.size.height

        let barH = CGFloat(44)

        let itemWH = screenWidth/4-1
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: barH, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "ImageCollectionCell")
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

        let barY = screenHeight-barH
        let barFrame = CGRect(x: 0, y: barY, width: screenWidth, height: barH)
        toolBar = UIToolbar(frame: barFrame)
        view.addSubview(toolBar)

        completeButton = ImageCompleteButton()
        completeButton.addTarget(target: self, action: #selector(finishSelect))
        completeButton.center = CGPoint(x: UIScreen.main.bounds.width - 50, y: 22)
        completeButton.isEnabled = false
        toolBar.addSubview(completeButton)

        imageManager = PHCachingImageManager()
        imageManager.stopCachingImagesForAllAssets()
    }

    @objc func rightItemAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    //获取已选择个数
    func selectedCount() -> Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }

    //完成按钮点击
    @objc func finishSelect(){
        //取出已选择的图片资源
        var assets:[PHAsset] = []
        if let indexPaths = self.collectionView.indexPathsForSelectedItems{
            for indexPath in indexPaths{
                assets.append(assetsFetchResults![indexPath.row] )
            }
        }
        //调用回调函数
        navigationController?.dismiss(animated: true, completion: {
            self.completeHandler?(assets)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    deinit {
        print("deinit == ImageCollectionController")
    }


}

extension ImageCollectionController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetsFetchResults?.count ?? 0
    }

    // 获取单元格
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取storyboard里设计的单元格，不需要再动态添加界面元素
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell",
                                                      for: indexPath) as! ImageCollectionCell
        let asset = assetsFetchResults![indexPath.row]
        //获取缩略图
        imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize,
                                       contentMode: .aspectFill, options: nil) {
                                        (image, nfo) in
                                        cell.imageView.image = image
        }

        return cell
    }

    //单元格选中响应
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionCell {
            //获取选中的数量
            let count = selectedCount()
            //如果选择的个数大于最大选择数
            if count > maxSelected {
                //设置为不选中状态
                collectionView.deselectItem(at: indexPath, animated: false)
                //弹出提示
                let title = "你最多只能选择\(maxSelected)张照片"
                let alertController = UIAlertController(title: title, message: nil,
                                                        preferredStyle: .alert)

                let cancelAction = UIAlertAction(title:"我知道了", style: .cancel,
                                                 handler:nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
                //如果不超过最大选择数
            else{
                //改变完成按钮数字，并播放动画
                completeButton.num = count
                if count > 0 && !completeButton.isEnabled {
                    completeButton.isEnabled = true
                }
                cell.playAnimate()
            }
        }
    }

    //单元格取消选中响应
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionCell {
            //获取选中的数量
            let count = selectedCount()
            completeButton.num = count
            //改变完成按钮数字，并播放动画
            if count == 0{
                completeButton.isEnabled = false
            }
            cell.playAnimate()
        }
    }

}
