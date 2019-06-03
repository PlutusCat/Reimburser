//
//  Toast+DefaultConfig.swift
//  Quickworker
//
//  Created by PlutusCat on 2018/9/28.
//  Copyright © 2018 Quickworker. All rights reserved.
//

import Toast_Swift

extension ToastManager {
    public class func defaultConfig() {
        var style = ToastStyle()
        style.displayShadow = true
        style.shadowOpacity = 0.7
        style.shadowOffset = CGSize(width: 2.0, height: 2.0)
        style.activitySize = CGSize(width: 90.0, height: 90.0)
        style.activityBackgroundColor = UIColor.black.withAlphaComponent(0.9)
        style.backgroundColor = style.activityBackgroundColor
        ToastManager.shared.style = style
        ToastManager.shared.position = .center
    }
}

extension UIView {
    public func dismissToasts() {
        self.hideAllToasts()
        self.hideToastActivity()
    }

    public func toTitleToast(message: String, _ position: ToastPoint = .center) {
        dismissToasts()
        makeToast(message, duration: 3.5, position: position, completion: nil)
    }

    public class func showOnWindow(message: String, _ position: ToastPoint = .center) {
        let rootController = UIApplication.shared.keyWindow?.rootViewController
        var view: UIView?
        if let root = rootController?.presentedViewController, root.isKind(of: LoginViewController.self) {
            view = root.view
        } else {
            view = rootController?.view
        }
        view?.makeToast(message, position: position, completion: nil)
    }

    public func showError(message: String = "") {
        if message.isEmpty { return }
        self.dismissToasts()
        let view = UIApplication.shared.keyWindow?.rootViewController?.view
        if let view = view {
            view.makeToast(message)
        }
    }

    func makeToast(_ message: String, duration: TimeInterval = ToastManager.shared.duration, position: ToastPoint = .center, completion: ((_ didTap: Bool) -> Void)? = nil) {
        do {
            let toast = try toastViewForMessage(message, title: nil, image: nil, style: ToastManager.shared.style)
            let point = position.centerPoint(forToast: toast, inSuperview: self)
            showToast(toast, duration: duration, point: point, completion: completion)
        } catch {}
    }
}

public enum ToastPoint {
    case top
    case center
    case bottom

    fileprivate func centerPoint(forToast toast: UIView, inSuperview superview: UIView) -> CGPoint {
        let topPadding: CGFloat = Layout.getNavigationHeight()+20
        let bottomPadding: CGFloat = Layout.getTabbarHeight()+20

        let size = superview.bounds.size
        switch self {
        case .top:
            return CGPoint(x: size.width*0.5, y: (toast.frame.size.height*0.5) + topPadding)
        case .center:
            return CGPoint(x: size.width*0.5, y: size.height*0.5)
        case .bottom:
            return CGPoint(x: size.width*0.5, y: (size.height - toast.frame.size.height*0.5) - bottomPadding)
        }
    }
}
