//
//  UIImageView.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/28.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(string: String) {
        if string.isEmpty { return }

        let resource = ImageResource(downloadURL: URL(string: string)!)
        let processor = DownsamplingImageProcessor(size: self.frame.size)
        self.kf.setImage(
            with: resource,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
        ]) { result in
            switch result {
            case .success(let value):
                printm("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                printm("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
