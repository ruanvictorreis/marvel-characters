//
//  EmptyCharacterListView.swift
//  Marvel
//
//  Created by Ruan Reis on 09/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit
import SnapKit

class EmptyCharacterListView: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = R.image.thanos()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .semiBoldSystemFont(ofSize: 20)
        label.text = R.Localizable.noResultFound()
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.text = R.Localizable.thanosKillEveryone()
        return label
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
}

// MARK: - ViewCodeProtocol Extension

extension EmptyCharacterListView: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(logo)
        addSubview(title)
        addSubview(subtitle)
    }
    
    func setupConstraints() {
        logo.snp.makeConstraints { make in
            make.width.height.equalTo(128)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(logo.snp.bottom).offset(8)
        }
        
        subtitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(title.snp.bottom).offset(8)
        }
    }
}
