//
//  UILoveItButton.swift
//  Marvel
//
//  Created by Ruan Reis on 08/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

class UILoveItButton: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var contentView: UICircularView = {
        let circularView = UICircularView(frame: .zero)
        circularView.backgroundColor = .white
        return circularView
    }()
    
    private lazy var heartButton: UIHeartButton = {
        let button = UIHeartButton()
        return button
    }()
    
    // MARK: - Public Properties
    
    var isFilled: Bool {
        get {
            heartButton.isFilled
        }
        set {
            heartButton.isFilled = newValue
        }
    }
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Public Functions
    
    func toggleIt() {
        heartButton.toggleIt()
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        heartButton.addTarget(target, action: action, for: controlEvents)
    }
}

// MARK: - ViewCodeProtocol Extension

extension UILoveItButton: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(contentView)
        contentView.addSubview(heartButton)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.bottom.right.equalToSuperview()
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(4)
            make.bottom.right.equalToSuperview().inset(4)
        }
    }
}
