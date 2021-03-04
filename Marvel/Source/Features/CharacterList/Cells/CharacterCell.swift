//
//  CharacterCell.swift
//  Marvel
//
//  Created by Ruan Reis on 08/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    lazy private var contentCard: UICardView = {
        let cardView = UICardView()
        cardView.shadowOpacity = 0.6
        return cardView
    }()
    
    lazy private var characterCard: UICardView = {
        let cardView = UICardView()
        cardView.clipsToBounds = true
        cardView.backgroundColor = .darkness
        return cardView
    }()
    
    lazy private var characterName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy private var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy private var loveItContainer: UICircularView = {
        let circularView = UICircularView()
        circularView.backgroundColor = .white
        return circularView
    }()
    
    lazy private var loveItButton: UIHeartButton = {
        return UIHeartButton()
    }()
    
    // MARK: - Public Properties
    
    weak var delegate: CharacterCellDelegate?
    
    static let identifier = String(describing: CharacterCell.self)
    
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
    
    func setup(_ viewModel: CharacterViewModel) {
        characterName.text = viewModel.name
        characterImage.load(url: viewModel.image)
        loveItButton.isFilled = viewModel.isLoved
    }
    
    // MARK: - Private Functions
    
    private func clearForReuse() {
        characterName.text = nil
        characterImage.image = nil
        loveItButton.isFilled = false
        characterImage.cancel()
    }
    
    @objc
    private func loveIt(_ sender: UIHeartButton) {
        loveItButton.toggleIt()
        
        let value = loveItButton.isFilled
        delegate?.setFavorite(self, value: value)
    }
}

// MARK: - ViewCodeProtocol Extension

extension CharacterCell: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(contentCard)
        contentCard.addSubview(characterCard)
        characterCard.addSubview(characterName)
        characterCard.addSubview(characterImage)
        characterCard.addSubview(loveItContainer)
        loveItContainer.addSubview(loveItButton)
    }
    
    func setupConstraints() {
        contentCard.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        
        characterCard.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        
        characterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        characterName.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(16)
            make.top.equalTo(characterImage.snp.bottom).offset(16)
        }
        
        loveItContainer.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.right.equalToSuperview().inset(4)
            make.top.equalTo(characterImage.snp.bottom).inset(15)
        }
        
        loveItButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(4)
            make.right.bottom.equalToSuperview().inset(4)
        }
    }
    
    func setupBehaviors() {
        loveItButton.addTarget(
            self, action: #selector(loveIt), for: .touchUpInside)
    }
}
