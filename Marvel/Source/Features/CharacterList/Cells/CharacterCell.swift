//
//  CharacterCell.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var characterName: UILabel!
    
    @IBOutlet private var characterImage: UIImageView!
    
    @IBOutlet private var loveItButton: UIHeartButton!
    
    // MARK: - Public Properties
    
    weak var delegate: CharacterCellDelegate?
    
    static let identifier = String(describing: CharacterCell.self)
    
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
    
    @IBAction private func loveIt(_ sender: UIHeartButton) {
        loveItButton.toggleIt()
        
        let value = loveItButton.isFilled
        delegate?.setFavorite(self, value: value)
    }
}
