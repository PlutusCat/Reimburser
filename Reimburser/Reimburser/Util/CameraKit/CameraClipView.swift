//
//  CameraClipView.swift
//  CameraKit
//
//  Created by PlutusCat on 2018/12/25.
//  Copyright © 2018 CameraKit. All rights reserved.
//

import UIKit

class CameraClipView: UIView {

    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    private var norRect: CGRect!
    private var showRect: CGRect!

    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var coverView: CameraClipCoverView = {
        let coverView = CameraClipCoverView()
        return coverView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black

//        let ret = image.size.height/image.size.width
//        imageView.frame.height = imageView.frame.width*ret
//        imageView.center = self.center
        addSubview(imageView)

        createSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createSubViews() {

        coverView.addGestureRecognizer(UIGestureRecognizer(target: self,
                                                           action: #selector(panAction(sender:))))
        coverView.addGestureRecognizer(UIGestureRecognizer(target: self,
                                                          action: #selector(pinAction(sender:))))
        showRect = CGRect(x: 0,
                          y: frame.size.height*0.15,
                          width: frame.size.width-2,
                          height: frame.size.width-2)
        addSubview(coverView)

    }

    @objc func panAction(sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: self)
        imageView.center = CGPoint(x: imageView.center.x+point.x,
                                   y: imageView.center.y+point.y)
        sender.setTranslation(.zero, in: self)

        if sender.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.imageView.frame = self.norRect
            }
        }
    }

    @objc func pinAction(sender: UIPanGestureRecognizer) {

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        coverView.snp.makeConstraints { (make) in
            make.edges.equalTo(imageView)
        }
    }

}
