//
//  LoginViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/27.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift

class LoginViewController: BaseViewController {

    @IBOutlet weak var uername: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var wechatBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

//        if WXApi.isWXAppInstalled() {
//            wechatBtn.isHidden = false
//        }
//        if WXApi.isWXAppSupport() {
            wechatBtn.isHidden = false
//        }
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func weChatLogin(_ sender: UIButton) {
        dismiss(animated: true) {
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "123"
            WXApi.send(req)
        }
    }
    @IBAction func loginAction(_ sender: UIButton) {
        login()
    }
}

extension LoginViewController {
    private func login() {
        guard let user = uername.text else {
            printm("输入用户名")
            view.makeToast("请输入用户名")
            return
        }
        guard let password = password.text else {
            printm("输入密码")
            view.makeToast("请输入密码")
            return
        }
        
        let paramet: Parameters = ["account": user,
                                   "password": password,
                                   "type": "pwd"]
        NetworkManager.request(URLString: API.login, paramet: paramet, token: false, finishedCallback: { (result) in
            let json = JSON(result).dictionaryValue
            let model = LoginRealm.from(json: json)
            if let code = model.owner?.code, NetworkResult.isCompleted(code: code) {
                JPUSHService.setAlias(model.userInfo?.uid, completion: { (iResCode, iAlias, _) in
                    if iResCode == 0 {
                        printm("极光别名注册成功 iAlias=\(iAlias ?? "iAlias 为空")" )
                    }
                }, seq: 000)
                DispatchQueue.main.async {
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(model, update: true)
                    }
                    self.dismiss(animated: true, completion: {
                        LoginManager.login(type: .phone, token: model.token)
                    })
                }
            } else {
                let msg = model.owner?.msg ?? "数据出现错误"
                printm(msg)
                self.view.showError(message: msg)
            }
        }) { (error) in
            printm("网络请求出现错误")
            self.view.showError(message: "网络请求出现错误")
        }
    }
}
