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

    private let player: IJKFFMoviePlayerController = {
        let ijkView = IJKFFMoviePlayerController()
        return ijkView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "视频"
        getVideoList()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.toastShow(type: .success)
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
            printm(json)
        }) { (error) in
            
        }
    }

}
