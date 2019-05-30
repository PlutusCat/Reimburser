//
//  PermissionsKit.swift
//  CameraKit
//
//  Created by PlutusCat on 2018/12/24.
//  Copyright © 2018 CameraKit. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class PermissionsKit: NSObject {

    //MARK:- 判断当前系统是否允许访问相机
    class func visitCamera() -> Bool{

        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .restricted,
             .denied:
            AlertViewManager.alertDefault(title: "提示", mesStr: "该功能需要打开相机权限，请点击设置开启相机权限。", continueStr: "去设置", handler: {

                let settingURL = URL(string: UIApplication.openSettingsURLString)

                if UIApplication.shared.canOpenURL(settingURL!) {
                    UIApplication.shared.open(settingURL!,
                                              options: [:],
                                              completionHandler: nil)
                }
            })
            return false
        default:
            return true
        }

    }

    //MARK:- 判断当前系统是否允许访问相册
    class func visitAlbum() -> Bool{

        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
        case .restricted,
             .denied:
            AlertViewManager.alertDefault(title: "提示", mesStr: "该功能需要打开访问相册权限，请点击设置开启相册权限。", continueStr: "去设置", handler: {
                let settingURL = URL(string: UIApplication.openSettingsURLString)
                if UIApplication.shared.canOpenURL(settingURL!) {
                    UIApplication.shared.open(settingURL!,
                                              options: [:],
                                              completionHandler: nil)
                }
            })
            return false
        default:
            return true
        }

    }

    //MARK:- 判断当前系统是否允许访问麦克风
    class func visitMicrophone() -> Bool{

        let authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authStatus {
        case .restricted,
             .denied:
            return false
        default:
            return true
        }
    }


    


}
