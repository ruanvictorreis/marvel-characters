//
//  ComicBookCell.swift
//  Marvel
//
//  Created by Ruan Reis on 07/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

class ComicBookCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private var comicImage: UIImageView!
    
    // MARK: - Public Properties
    
    static var size = CGSize(width: 140.0, height: 210.0)
    
    static let identifier = String(describing: ComicBookCell.self)
    
    // MARK: - View Lifecycle
    
    override func prepareForReuse() {
        clearForReuse()
    }
    
    // MARK: - Public Functions
    
    func setup(_ viewModel: ComicViewModel) {
        comicImage.load(url: viewModel.image)
    }
    
    // MARK: - Private Functions
    
    private func clearForReuse() {
        comicImage.image = nil
        comicImage.cancel()
    }
}
