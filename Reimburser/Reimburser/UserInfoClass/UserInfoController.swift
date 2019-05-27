//
//  UserInfoController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/23.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class UserInfoController: BaseViewController {

    private lazy var userTableView: UserInfoTableView = {
        let tableview = UserInfoTableView(frame: .zero, style: .plain)
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
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.id) as! UserInfoTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
