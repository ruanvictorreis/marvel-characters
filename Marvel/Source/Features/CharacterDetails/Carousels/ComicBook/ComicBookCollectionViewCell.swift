//
//  ComicBookCollectionViewCell.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

class ComicBookCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var comicBookImage: UIImageView!
    
    // MARK: - Public Properties
    
    static var size = CGSize(width: 140.0, height: 210.0)
    
    // MARK: - Public Functions
    
    override func prepareForReuse() {
        clearForReuse()
    }
    
    func setup(_ comicBook: ComicBook) {
        let thumbnail = comicBook.thumbnail
        let imageUrl = "\(thumbnail.path).\(thumbnail.extension)"
        comicBookImage.load(url: imageUrl)
    }
    
    // MARK: - Private Functions
    
    private func clearForReuse() {
        comicBookImage.image = nil
        comicBookImage.cancel()
    }
}
