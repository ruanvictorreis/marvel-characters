//
//  ComicBookCarouselView.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import SnapKit

class ComicBookCarouselView: UIView {
    
    // MARK: - UI Components
    
    lazy private var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .semiBoldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy private var loading: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .horizontal
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

extension ComicBookCarouselView: ViewCodeProtocol {
    
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
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.top.equalTo(title.snp.bottom).offset(16)
        }
    }
    
    func setupComponents() {
        title.text = R.Localizable.comics()
        collectionView.delegate = self
        collectionView.dataSource = self
        ComicBookCell.registerOn(collectionView)
    }
}

// MARK: - UICollectionView Protocol Extensions

extension ComicBookCarouselView: UICollectionViewDataSource {
    
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

extension ComicBookCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ComicBookCell.size
    }
}
