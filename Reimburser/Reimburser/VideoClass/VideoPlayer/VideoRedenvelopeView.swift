//
//  VideoRedenvelopeView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/6/4.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit

class VideoRedenvelopeView: UIView {
    
    lazy var redenvelope: Redenvelope = {
        let view = Redenvelope.subView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(redenvelope)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        redenvelope.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 220))
        }
    }

}

extension Redenvelope {
    class func subView() -> Redenvelope {
        return Bundle.main.loadNibNamed("Redenvelope", owner: nil, options: nil)?.first as! Redenvelope
    }
}

class Redenvelope: UIView {

    var tapGestureBack: (() -> Void)?
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var getBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func getAmountAction(_ sender: UIButton) {
        if let get = tapGestureBack {
            get()
        }
    }
}
