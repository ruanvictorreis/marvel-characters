//
//  UIHeartButton.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

@IBDesignable
class UIHeartButton: UIButton {
    
    // MARK: - Public Properties
    
    var isFilled: Bool = false {
        didSet {
            animate()
        }
    }
    
    // MARK: - Private Properties
    
    private var imageScale: CGFloat = 0.7
    
    private var heartImage: UIImage? = R.image.heart_outline()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        self.accessibilityIdentifier = "heartButtonId"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        
        self.accessibilityIdentifier = "heartButtonId"
    }
    
    // MARK: - Public Functions
    
    func toggleIt() {
        isFilled = !isFilled
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        setupImage()
        self.setTitle(nil, for: .normal)
        self.setImage(heartImage, for: .normal)
    }
    
    private func setupImage() {
        imageScale = isFilled
            ? CGFloat(1.3)
            : CGFloat(0.7)
        
        heartImage = isFilled
            ? R.image.heart_filled()
            : R.image.heart_outline()
        
        heartImage?.withRenderingMode(.alwaysOriginal)
    }
    
    private func animate() {
        UIView.animate(
            withDuration: 0.1,
            animations: {
                self.setupUI()
                self.transform = self.transform.scaledBy(
                    x: self.imageScale, y: self.imageScale)
            },
            completion: { [weak self] _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self?.transform = CGAffineTransform.identity
                })
            })
    }
}
