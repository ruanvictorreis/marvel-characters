//
//  ComicBookCarousel.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import SnapKit

class ComicBookCarousel: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .semiBoldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Private Properties
    
    private var comics: [ComicViewModel] = []
    
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
    
    func setup(_ comics: [ComicViewModel]) {
        self.comics = comics
        collectionView.reloadData()
    }
    
    func startLoading() {
        loading.startAnimating()
        loading.isHidden = false
    }
    
    func stopLoading() {
        loading.stopAnimating()
        loading.isHidden = true
    }
}

// MARK: - ViewCodeProtocol Extension

extension ComicBookCarousel: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(title)
        addSubview(loading)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        loading.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(210)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.top.equalTo(title.snp.bottom).offset(16)
        }
    }
    
    func setupComponents() {
        backgroundColor = .systemBackground
        title.text = R.Localizable.comics()
        collectionView.delegate = self
        collectionView.dataSource = self
        ComicBookCell.registerOn(collectionView)
    }
}

// MARK: - UICollectionView Protocol Extensions

extension ComicBookCarousel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = ComicBookCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? ComicBookCell else { return UICollectionViewCell() }
        
        cell.setup(comics[indexPath.item])
        
        return cell
    }
}

extension ComicBookCarousel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ComicBookCell.size
    }
}
