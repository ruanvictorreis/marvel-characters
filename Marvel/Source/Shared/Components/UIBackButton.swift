//
//  UIBackButton.swift
//  Marvel
//
//  Created by Ruan Reis on 08/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

class UIBackButton: UIButton {
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Private Properties
    
    private func setupUI() {
        self.tintColor = .lightFog
        self.accessibilityIdentifier = "backButtonId"
        self.setImage(R.image.icon_back(), for: .normal)
    }
}
