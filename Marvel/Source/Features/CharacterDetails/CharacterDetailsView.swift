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
    
    lazy private var characterThumbnail: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .darkness
        return imageView
    }()
    
    lazy private var loveItContainer: UICircularView = {
        let circularView = UICircularView(frame: .zero)
        circularView.backgroundColor = .white
        return circularView
    }()
    
    lazy private var loveItButton: UIHeartButton = {
        return UIHeartButton(frame: .zero)
    }()
    
    lazy private var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        return button
    }()
    
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()
    
    lazy private var scrollContent: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    lazy private var detailsContent: UICardView = {
        let cardView = UICardView(frame: .zero)
        cardView.cornerRadius = 20
        cardView.backgroundColor = .systemBackground
        return cardView
    }()
    
    lazy private var characterName: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy private var characterDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy private var comicsCarousel: ComicBookCarouselView = {
        let view = ComicBookCarouselView(frame: .zero)
        view.backgroundColor = .systemBackground
        return view
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
        addSubview(loveItContainer)
        scrollView.addSubview(scrollContent)
        scrollContent.addSubview(detailsContent)
        detailsContent.addSubview(characterName)
        detailsContent.addSubview(characterDescription)
        detailsContent.addSubview(comicsCarousel)
        loveItContainer.addSubview(loveItButton)
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
            make.right.equalToSuperview().inset(16)
            make.top.left.equalToSuperview().offset(16)
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
            make.width.equalTo(45)
            make.height.equalTo(55)
            make.top.left.equalTo(safeAreaLayoutGuide)
        }
        
        loveItContainer.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(detailsContent.snp.top).offset(20)
        }
        
        loveItButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(4)
            make.right.bottom.equalToSuperview().inset(4)
        }
    }
    
    func setupComponents() {
        backgroundColor = .systemBackground
        backButton.tintColor = .lightFog
        backButton.accessibilityIdentifier = "backButtonId"
        backButton.setImage(R.image.icon_back(), for: .normal)
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        loveItButton.addTarget(self, action: #selector(loveIt), for: .touchUpInside)
    }
}
