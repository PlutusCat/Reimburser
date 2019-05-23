//
//  ViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/23.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import ViewAnimator
import IJKMediaFramework
import SnapKit

class ViewController: BaseViewController {

    private let player: IJKFFMoviePlayerController = {
        let ijkView = IJKFFMoviePlayerController()
        return ijkView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "001"
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.yellow
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 80, height: 30))
            make.center.equalToSuperview()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.toastShow(type: .success)
    }
    @objc func add() {
        view.toastDiss()
    }
}

