//
//  WalletViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/29.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire

class WalletViewController: BaseViewController {

    @IBOutlet weak var walletIcon: UIImageView!
    @IBOutlet weak var walletTitle: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var subIcon: UIImageView!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var amountBtn01: UIButton!
    @IBOutlet weak var amountBtn02: UIButton!
    @IBOutlet weak var amountBtn03: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    
    /// 准备提现金额
    private var amount = ""
    /// 现有余额
    private var money = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的钱包"
        getWalletInfo()
    }

    @IBAction func amountAction01(_ sender: UIButton) {
        reloadCashTitle(sender)
    }
    @IBAction func amountAction02(_ sender: UIButton) {
        reloadCashTitle(sender)
    }
    @IBAction func amountAction03(_ sender: UIButton) {
        reloadCashTitle(sender)
    }
    @IBAction func cashAction(_ sender: UIButton) {
        getWalletWithdraw()
    }
    
    private func getWalletInfo() {
        
        NetworkManager.request(URLString: API.walletInfo, finishedCallback: { (result) in
            let json = JSON(result)
            let model = WalletInfoRealm.from(json: json.dictionaryValue)
            if let code = model.owner?.code, NetworkResult.isCompleted(code: code) {
                DispatchQueue.main.async {
                    self.money = model.money
                    self.amountLabel.text = model.money
                    self.compare(have: model.money, extract: "50")
                }
            } else {
                printm(model.owner?.msg ?? "数据服务出现错误")
            }
        }) { (error) in
            printm("网络请求出现错误")
        }
    }

    private func getWalletWithdraw() {
        let paramet: Parameters = ["amount": Double(amount) ?? 0.00,
                                   "app": "wechat"]
        NetworkManager.request(URLString: API.walletWithdraw, paramet: paramet, finishedCallback: { (result) in
            let json = JSON(result)
            let model = BaseModel.from(dictionary: json.dictionaryValue)
            if NetworkResult.isCompleted(code: model.code) {
                /// 提现成功
                printm(model.msg)
            } else {
                printm(model.msg)
            }
        }) { (error) in
            printm("网络请求出现错误")
        }
    }
    
    private func reloadCashTitle(_ sender: UIButton) {
        guard let amount = sender.titleLabel?.text else {
            printm("没有获取到提取金额参数")
            return
        }
        if amount.hasPrefix("￥50") {
            self.amount = "50"
        } else if amount.hasPrefix("￥100") {
            self.amount = "100"
        } else if amount.hasPrefix("￥150") {
            self.amount = "150"
        }
        
        compare(have: money, extract: self.amount)
    }
    
    @discardableResult
    private func compare(have: String, extract: String) -> Bool {
        /// 现有
        let newMoney = NSDecimalNumber(string: have)
        /// 准备提取
        let newAmount = NSDecimalNumber(string: extract)
        let result = newMoney.compare(newAmount)
        if result == .orderedAscending {
            printm("您要提取的金额不满足，暂时无法提现")
            cashBtn.isEnabled = false
            cashBtn.setTitle("您的余额不足，暂时无法提现", for: .normal)
            return false
        } else {
            printm("提现中...")
            cashBtn.isEnabled = true
            let title = "提取到微信 " + amount
            cashBtn.setTitle(title, for: .normal)
            return true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubViews()
    }
}

extension WalletViewController {
    private func layoutSubViews() {
        walletIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 24, height: 30))
            make.left.equalTo(16)
            make.top.equalTo(Layout.getNavigationHeight()+16)
        }
        walletTitle.snp.makeConstraints { (make) in
            make.left.equalTo(walletIcon.snp.right).offset(16)
            make.right.equalToSuperview()
            make.centerY.equalTo(walletIcon)
        }
        amountLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(walletTitle)
            make.top.equalTo(walletTitle.snp.bottom)
        }
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
            make.top.equalTo(amountLabel.snp.bottom)
        }
        subIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 6, height: 24))
            make.left.equalTo(walletIcon)
            make.top.equalTo(line).offset(20)
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.left.equalTo(subIcon.snp.right).offset(8)
            make.right.equalToSuperview()
            make.centerY.equalTo(subIcon)
        }
        let heng = CGFloat(16)
        let btnW = (Layout.screen.size.width-heng*3)*0.5
        amountBtn01.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: btnW, height: 100))
            make.top.equalTo(subTitle.snp.bottom).offset(20)
            make.left.equalTo(heng)
        }
        amountBtn02.snp.makeConstraints { (make) in
            make.size.equalTo(amountBtn01)
            make.top.equalTo(amountBtn01)
            make.right.equalToSuperview().inset(heng)
        }
        amountBtn03.snp.makeConstraints { (make) in
            make.size.equalTo(amountBtn01)
            make.top.equalTo(amountBtn01.snp.bottom).offset(20)
            make.left.equalTo(amountBtn01)
        }
        cashBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(amountBtn03.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(68)
        }
    }
}
