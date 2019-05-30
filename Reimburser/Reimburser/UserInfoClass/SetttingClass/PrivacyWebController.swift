//
//  PrivacyWebController.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/10/17.
//  Copyright © 2018 SwiftToolsKit. All rights reserved.
//

import UIKit

class PrivacyWebController: BaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        isShowMore = false

        load(URLRequest(url: URL(string: API.privacyURL)!))
    }
    
}
