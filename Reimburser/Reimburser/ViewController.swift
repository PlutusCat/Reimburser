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

class ViewController: BaseViewController {

    private let player: IJKFFMoviePlayerController = {
        let ijkView = IJKFFMoviePlayerController()
        return ijkView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "001"
        view.backgroundColor = UIColor.red00
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.toastShow(type: .success)
    }
}

