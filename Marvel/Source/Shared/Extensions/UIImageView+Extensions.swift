//
//  UIImageView+Extensions.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func load(url: String, completion: (() -> Void)? = nil) {
        guard url.notContains("image_not_available") else { return }
        
        kf.setImage(
            with: URL(string: url),
            options: [.transition(.fade(0.3))]) { _ in
                completion?()
        }
    }
    
    func cancel() {
        kf.cancelDownloadTask()
    }
}
