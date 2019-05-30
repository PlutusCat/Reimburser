//
//  UserInfoController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/23.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift
import RxRealm
import RxSwift

class UserInfoController: BaseViewController {

    private var setModels = [1: [Setitem(icon: "icon_repair", title: "设置")]]
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCell), name: NotificationNames.loginSuccess, object: nil)
        userTableView.tableHeaderView = tableHeader
        tableHeader.tapGestureBack = { [weak self] in
            let login = LoginViewController()
            self?.present(login, animated: true, completion: nil)
        }
        isLogined()
    }
    
    private func isLogined() {
        let realm = try! Realm()
        if let login = realm.object(ofType: LoginManagerRealm.self, forPrimaryKey: loginManagerRealmKey) {
            switch login.type {
            case 1:
                loadCellInWechat()
            case 2:
                loadCellInPhone()
            default:
                printm("未知登陆状态")
                break
            }
        }
    }

    @objc private func reloadCell(_ sender: Notification) {
        let type = sender.object as! LoginType
        switch type {
        case .wx:
            loadCellInWechat()
        case .phone:
            loadCellInPhone()
        default:
            printm("未知登陆状态")
            break
        }
    }
    
    private func loadCellInWechat() {
        printm("微信登陆")
        let realm = try! Realm()
        if let user = realm.object(ofType: WXUserInfoRealm.self, forPrimaryKey: wxUserInfoKey) {
            tableHeader.isUserInteractionEnabled = false
            tableHeader.title.text = user.nickname
            tableHeader.headerIcon.setImage(string: user.headimgurl)
            
            setModels[0] = [Setitem(icon: "icon_wallet-1", title: "我的钱包")]
            userTableView.reloadData()
            
            if let user = realm.object(ofType: LoginRealm.self, forPrimaryKey: loginKey) {
                try! realm.write {
                    realm.delete(user)
                }
            }
        }
    }
    private func loadCellInPhone() {
        printm("手机号登陆")
        let realm = try! Realm()
        if let user = realm.object(ofType: LoginRealm.self, forPrimaryKey: loginKey) {
            tableHeader.isUserInteractionEnabled = false
            tableHeader.title.text = user.data.userInfo.phone
            
            if let user = realm.object(ofType: WXUserInfoRealm.self, forPrimaryKey: wxUserInfoKey) {
                try! realm.write {
                    realm.delete(user)
                }
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        switch indexPath.section {
        case 0:
            let vc = WalletViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            switch indexPath.row {
            case 0:
                let vc = SettingViewController()
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}


