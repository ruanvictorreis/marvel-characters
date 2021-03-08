//
//  ComicBookCell.swift
//  Marvel
//
//  Created by Ruan Reis on 07/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit
import SnapKit

class ComicBookCell: UICollectionViewCell {
    
    // MARK: - User Interface Components
    
    private lazy var contentCard: UICardView = {
        let cardView = UICardView(frame: .zero)
        cardView.shadowOpacity = 0.6
        return cardView
    }()
    
    private lazy var thumbnailCard: UICardView = {
        let cardView = UICardView(frame: .zero)
        cardView.clipsToBounds = true
        cardView.backgroundColor = .darkness
        return cardView
    }()
    
    private lazy var thumbnail: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Public Properties
    
    static var size = CGSize(width: 140.0, height: 210.0)
    
    static let identifier = String(describing: ComicBookCell.self)
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - View Lifecycle
    
    override func prepareForReuse() {
        clearForReuse()
    }
    
    // MARK: - Public Functions
    
    func setup(_ viewModel: ComicViewModel) {
        thumbnail.load(url: viewModel.image)
    }
    
    // MARK: - Private Functions
    
    private func clearForReuse() {
        thumbnail.image = nil
        thumbnail.cancel()
    }
}

// MARK: - ViewCodeProtocol Extension

extension ComicBookCell: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(contentCard)
        contentCard.addSubview(thumbnailCard)
        thumbnailCard.addSubview(thumbnail)
    }
    
    func setupConstraints() {
        contentCard.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        
        thumbnailCard.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        
        thumbnail.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
    }
}
