//
//  FontKit.swift
//  FacialAudit
//
//  Created by cindata_mac on 2019/4/3.
//  Copyright © 2019 FacialAudit. All rights reserved.
//

import Foundation

extension UIFont {
    public static var defaultValue: UIFont {
        return UIFont.systemFont(ofSize: 28)
    }

    public static var title01: UIFont {
        return UIFont.systemFont(ofSize: 28)
    }

    public static var title02: UIFont {
        return UIFont.systemFont(ofSize: 22)
    }

    public static var title03: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }

    public static var body: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }

    public static var callout: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }

    public static var subHead: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }

    public static var footNote: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }

    public static var caption01: UIFont {
        return UIFont.systemFont(ofSize: 12)
    }

    public static var caption02: UIFont {
        return UIFont.systemFont(ofSize: 11)
    }

    public class func autoSize(ofSize fontSize: CGFloat, isBold: Bool = false) -> UIFont {
        if isBold {
            if UIDevice.isPhone {
                return UIFont.boldSystemFont(ofSize: fontSize)
            } else {
                return UIFont.boldSystemFont(ofSize: fontSize*1.6)
            }
        } else {
            if UIDevice.isPhone {
                return UIFont.systemFont(ofSize: fontSize)
            } else {
                return UIFont.systemFont(ofSize: fontSize*1.6)
            }
        }
    }
}
