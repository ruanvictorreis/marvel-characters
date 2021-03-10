//
//  CharacterDetailsView.swift
//  Marvel
//
//  Created by Ruan Reis on 07/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit
import SnapKit

class CharacterDetailsView: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var characterThumbnail: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .darkness
        return imageView
    }()
    
    private lazy var loveItButton: UILoveItButton = {
        return UILoveItButton(frame: .zero)
    }()
    
    private lazy var backButton: UIBackButton = {
        return UIBackButton(frame: .zero)
    }()
    
    private lazy var scrollView: UIScrollView = {
        return UIScrollView(frame: .zero)
    }()
    
    private lazy var scrollContent: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    private lazy var detailsContent: UICardView = {
        let cardView = UICardView(frame: .zero)
        cardView.cornerRadius = 20
        cardView.backgroundColor = .systemBackground
        return cardView
    }()
    
    private lazy var characterName: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var characterDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var comicsCarousel: ComicBookCarousel = {
        return ComicBookCarousel(frame: .zero)
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
    
    weak var delegate: CharacterDetailsViewDelegate?
    
    // MARK: - Public Functions
    
    func setup(_ viewModel: CharacterDetailsViewModel) {
        characterName.text = viewModel.name
        comicsCarousel.setup(viewModel.comics)
        characterThumbnail.load(url: viewModel.image)
        set(description: viewModel.description)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.loveItButton.isFilled = viewModel.isLoved
        }
    }
    
    func startComicsLoading() {
        comicsCarousel.startLoading()
    }
    
    func stopComicsLoading() {
        comicsCarousel.stopLoading()
    }
    
    // MARK: - Private Functions
    
    private func set(description: String) {
        let attrString = NSMutableAttributedString(string: description)
        let attrRange = NSRange(location: 0, length: attrString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 3
        paragraphStyle.alignment = .justified
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.baseWritingDirection = .leftToRight
        
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle, range: attrRange)
        
        characterDescription.attributedText = attrString
    }
    
    @objc
    private func loveIt() {
        loveItButton.toggleIt()
        delegate?.loveIt(loveItButton.isFilled)
    }
    
    @objc
    private func close() {
        delegate?.close()
    }
}

// MARK: - ViewCodeProtocol Extension

extension CharacterDetailsView: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(characterThumbnail)
        addSubview(scrollView)
        addSubview(backButton)
        addSubview(loveItButton)
        scrollView.addSubview(scrollContent)
        scrollContent.addSubview(detailsContent)
        detailsContent.addSubview(characterName)
        detailsContent.addSubview(characterDescription)
        detailsContent.addSubview(comicsCarousel)
    }
    
    func setupConstraints() {
        characterThumbnail.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(detailsContent.snp.top).offset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        scrollContent.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        detailsContent.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(196)
            make.left.right.bottom.equalToSuperview()
        }
        
        characterName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        characterDescription.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(characterName.snp.bottom).offset(16)
        }
        
        comicsCarousel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
            make.top.equalTo(characterDescription.snp.bottom).offset(24)
        }
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.top.left.equalTo(safeAreaLayoutGuide).offset(8)
        }
        
        loveItButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(safeAreaLayoutGuide).inset(4)
            make.bottom.equalTo(detailsContent.snp.top).offset(20)
        }
    }
    
    func setupComponents() {
        backgroundColor = .systemBackground
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        loveItButton.addTarget(self, action: #selector(loveIt), for: .touchUpInside)
    }
}
