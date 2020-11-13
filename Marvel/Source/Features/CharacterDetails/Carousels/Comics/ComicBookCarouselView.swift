//
//  ComicBookCarouselView.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

class ComicBookCarouselView: UIView {
    
    // MARK: - IBOulets
    
    @IBOutlet private var title: UILabel!
    
    @IBOutlet private var loading: UIActivityIndicatorView!
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    private var comicBookList: [ComicViewModel] = []
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.text = R.Localizable.comics()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Public Functions
    
    func setup(_ comics: [ComicViewModel]) {
        comicBookList = comics
        collectionView.reloadData()
    }
    
    func startLoading() {
        loading.isHidden = false
    }
    
    func stopLoading() {
        loading.isHidden = true
    }
}

// MARK: - UICollectionViewDataSource Extension

extension ComicBookCarouselView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicBookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = ComicBookCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? ComicBookCell else { return UICollectionViewCell() }
        
        cell.setup(comicBookList[indexPath.item])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Extension

extension ComicBookCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ComicBookCell.size
    }
}
