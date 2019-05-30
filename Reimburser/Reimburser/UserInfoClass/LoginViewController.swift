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
//        guard let user = uername.text else {
//            printm("输入用户名")
//            return
//        }
//        guard let password = password.text else {
//            printm("输入密码")
//            return
//        }
        let paramet: Parameters = ["account": "17793873123",
                                   "password": "121101mxf",
                                   "type": "pwd"]
        NetworkManager.request(URLString: API.login, paramet: paramet, finishedCallback: { (result) in
            let json = JSON(result).dictionaryValue
            let model = LoginRealm.from(json: json)
            if let code = model.owner?.code, NetworkResult.isCompleted(code: code) {
                JPUSHService.setAlias(model.data?.userInfo.phone, completion: { (iResCode, iAlias, _) in
                    if iResCode == 0 {
                        printm("极光别名注册成功 iAlias=\(iAlias ?? "iAlias 为空")" )
                    }
                }, seq: 000)
                DispatchQueue.main.async {
                    LoginManager.login(type: .phone)
                }
            } else {
                printm(model.owner?.msg ?? "数据出现错误")
            }
        }) { (error) in
            printm("网络请求出现错误")
        }
    }
}
