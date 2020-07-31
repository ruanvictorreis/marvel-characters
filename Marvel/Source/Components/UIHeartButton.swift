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
    
    @IBInspectable var isFilled: Bool = false {
        didSet {
            animate()
        }
    }
    
    // MARK: - Private Properties
    
    private var imageScale: CGFloat = 0.7
    
    private var heartImage: UIImage? = R.image.heart_outline()
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Public Functions
    
    func toggleIt() {
        self.isFilled = !self.isFilled
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        setupImage()
        self.setTitle(nil, for: .normal)
        self.setImage(heartImage, for: .normal)
    }
    
    private func setupImage() {
        self.imageScale = isFilled
            ? CGFloat(1.3)
            : CGFloat(0.7)
        
        self.heartImage = isFilled
            ? R.image.heart_filled()
            : R.image.heart_outline()
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
