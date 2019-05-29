//
//  MainTabBarController.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/3/27.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import UIKit
import ViewAnimator

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configPages()
    }

    private func configPages() {
        let videoVC = VideoViewController(collectionViewLayout: VideosFlowLayout())
        addViewController(vc: videoVC,
                          barIcon: "item01",
                          barTitle: "现金任务")
        addViewController(vc: ReimbursViewController(),
                          barIcon: "item02",
                          barTitle: "全民报销")
        addViewController(vc: UserInfoController(),
                          barIcon: "item02",
                          barTitle: "我的")
    }

    private func addViewController(vc viewController: UIViewController,
                                   barIcon: String,
                                   barTitle: String) {

        let icon = UIImage(named: barIcon)?.withRenderingMode(.alwaysOriginal)
        let iconSelected = UIImage(named: barIcon+"_selected")?.withRenderingMode(.alwaysOriginal)
        let barItem = UITabBarItem(title: barTitle, image: icon, selectedImage: iconSelected)
        let normal = [NSAttributedString.Key.foregroundColor: UIColor.textGray]
        let selected = [NSAttributedString.Key.foregroundColor: UIColor.main]
        barItem.setTitleTextAttributes(normal, for: .normal)
        barItem.setTitleTextAttributes(selected, for: .selected)
        let vc = MainNavigationController(rootViewController: viewController)
        vc.tabBarItem = barItem

        addChild(vc)
    }
}

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        initialization()
        screenPanGes()

    }

    private func screenPanGes() {
        guard let systemGes = interactivePopGestureRecognizer else { return }
        guard let gesView = systemGes.view else { return }
        //从Targets 取出 Target
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        guard let target = targetObjc.value(forKey: "target") else { return }
        //方法名称获取 Action
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }

    private func initialization() {
        navigationBar.tintColor = .white
        navigationBar.barStyle = .black
        let image = UIImage(named: "navigationbar_backgroudcolor")
        navigationBar.setBackgroundImage(image,
                                         for: .any,
                                         barMetrics: .default)
        navigationBar.shadowImage = image
    }

    @objc private func backToPrevious() {
        popViewController(animated: true)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
