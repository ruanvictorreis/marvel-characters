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
    
    @IBOutlet private var loaging: UIActivityIndicatorView!
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    private var comicBookList: [ComicBook] = []
    
     // MARK: - Public Functions
    
    func setupUI() {
        title.text = R.Localizable.comics()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupUI(_ comics: [ComicBook]) {
        comicBookList = comics
        loaging.isHidden = true
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource Extension

extension ComicBookCarouselView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicBookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicBookCell", for: indexPath)
            as? ComicBookCollectionCell else { return UICollectionViewCell() }
        
        cell.setup(comicBookList[indexPath.item])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Extension

extension ComicBookCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ComicBookCollectionCell.size
    }
}
