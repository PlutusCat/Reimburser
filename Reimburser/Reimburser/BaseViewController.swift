//
//  BaseViewController.swift
//  FacialAudit
//
//  Created by PlutusCat on 2018/12/27.
//  Copyright © 2018 FacialAudit. All rights reserved.
//

import UIKit
import ViewAnimator

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }
    deinit {
        printm("*** ", self, "***")
    }
}
