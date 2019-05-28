//
//  UserInfoController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/23.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class UserInfoController: BaseViewController {

    private var setModels = [0: [Setitem(icon: "icon_wallet-1", title: "提现")],
                             1: [Setitem(icon: "icon_repair", title: "提现"),
                                 Setitem(icon: "icon_repair", title: "设置")]]
    private lazy var userTableView: UserInfoTableView = {
        let tableview = UserInfoTableView(frame: .zero, style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()

    private lazy var tableHeader: UserInfoHeader = {
        let header = UserInfoHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160))
        return header
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的"
        view.addSubview(userTableView)
        userTableView.tableHeaderView = tableHeader
        tableHeader.tapGestureBack = { [weak self] in
            let login = LoginViewController()
            self?.present(login, animated: true, completion: nil)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension UserInfoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}

extension UserInfoController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return setModels.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let models = setModels[section] {
            return models.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.id) as! UserInfoTableViewCell
        if let models = setModels[indexPath.section] {
            cell.set(model: models[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


