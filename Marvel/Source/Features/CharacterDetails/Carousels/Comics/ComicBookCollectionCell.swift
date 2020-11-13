//
//  ComicBookCollectionCell.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

class ComicBookCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var comicBookImage: UIImageView!
    
    // MARK: - Public Properties
    
    static var size = CGSize(width: 140.0, height: 210.0)
    
    // MARK: - Public Functions
    
    override func prepareForReuse() {
        clearForReuse()
    }
    
    func setup(_ viewModel: ComicViewModel) {
        comicBookImage.load(url: viewModel.image)
    }
    
    // MARK: - Private Functions
    
    private func clearForReuse() {
        comicBookImage.image = nil
        comicBookImage.cancel()
    }
}
