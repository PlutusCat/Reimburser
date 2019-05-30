//
//  BaseTableView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    func addFooter() {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: Layout.getSafeArea().bottom))
        tableFooterView = view
    }

}
