//
//  UIHeartButton.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

class UIHeartButton: UIButton {
    
    private var isLiked = false
    
    private let likedScale: CGFloat = 1.3
    
    private let unlikedScale: CGFloat = 0.7
    
    private let likedImage = R.image.heart_filled()
    
    private let unlikedImage = R.image.heart_outline()
    
    override public init(frame: CGRect) {
      super.init(frame: frame)
      setImage(unlikedImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setImage(unlikedImage, for: .normal)
    }

    public func flipLikedState() {
      isLiked = !isLiked
      animate()
    }

    private func animate() {
      UIView.animate(withDuration: 0.1, animations: {
        let newImage = self.isLiked ? self.likedImage : self.unlikedImage
        let newScale = self.isLiked ? self.likedScale : self.unlikedScale
        self.transform = self.transform.scaledBy(x: newScale, y: newScale)
        self.setImage(newImage, for: .normal)
      }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
          self.transform = CGAffineTransform.identity
        })
      })
    }
}
