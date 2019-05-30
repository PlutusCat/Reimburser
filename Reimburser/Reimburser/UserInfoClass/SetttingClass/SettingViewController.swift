//
//  SetttingViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {

    private var setModels = ["退出登陆"]
    private lazy var settingTableView: SettingTableView = {
        let tableview = SettingTableView(frame: .zero, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()

    private lazy var tableHeader: SettingHeader = {
        let header = SettingHeader()
        return header
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "设置"
        view.addSubview(settingTableView)
        view.addSubview(tableHeader)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingTableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(tableHeader.snp.bottom)
        }
        tableHeader.snp.makeConstraints { (make) in
            make.top.equalTo(Layout.getNavigationHeight())
            make.left.right.equalToSuperview()
        }
    }
    
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableCell.id) as! SettingTableCell
        cell.set(model: setModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            printm("退出登录")
        default:
            break
        }
    }
}
