//
//  WalletViewController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/29.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

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
    
    private var amount = ""
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let title = "提取到微信 " + amount
        cashBtn.setTitle(title, for: .normal)
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
