//
//  UIBackButton.swift
//  Marvel
//
//  Created by Ruan Reis on 08/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit
import SnapKit

class UIBackButton: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var contentView: UICircularView = {
        let view = UICircularView(frame: .zero)
        view.backgroundColor = .night
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = .lightFog
        return button
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Public Properties
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        backButton.addTarget(target, action: action, for: controlEvents)
    }
}

// MARK: - ViewCodeProtocol Extension

extension UIBackButton: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(contentView)
        contentView.addSubview(backButton)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
    }
    
    func setupComponents() {
        clipsToBounds = false
        backgroundColor = .clear
        
        backButton.accessibilityIdentifier = "backButtonId"
        backButton.setImage(R.image.icon_back(), for: .normal)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
