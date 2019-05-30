//
//  CameraClipCoverView.swift
//  CameraKit
//
//  Created by PlutusCat on 2018/12/25.
//  Copyright © 2018 CameraKit. All rights reserved.
//

import UIKit

class CameraClipCoverView: UIView {

    private var showRect: CGRect!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

//        let ctx = UIGraphicsGetCurrentContext()
//        ctx?.setFillColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 0.6)
//        ctx?.addRect(rect)
//
//        let clearDrawRect = showRect
//        ctx?.clear(clearDrawRect!)
//        ctx?.stroke(clearDrawRect!)
//        ctx?.setStrokeColor(red: 1, green: 1, blue: 1, alpha: 1)
//        ctx?.strokePath()

//        let context = UIGraphicsGetCurrentContext()

    }

}
