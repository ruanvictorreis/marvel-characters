//
//  CharacterCollectionCell.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterCellDelegate: AnyObject {
    
    func setFavorite(_ character: Character)
}

class CharacterCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var characterName: UILabel!
    
    @IBOutlet private var characterImage: UIImageView!
    
    @IBOutlet private var loveItButton: UIHeartButton!
    
    // MARK: - Public Properties
    
     weak var delegate: CharacterCellDelegate?
    
    // MARK: - Private Properties
    
    private var character: Character?
    
    // MARK: - Public Functions
    
    override func prepareForReuse() {
        clearForReuse()
    }
    
    func setup(character: Character) {
        self.character = character
        characterName.text = character.name
        loveItButton.isFilled = character.isFavorite
        
        let thumbnail = character.thumbnail
        let imageUrl = "\(thumbnail.path).\(thumbnail.extension)"
        characterImage.load(url: imageUrl)
    }
    
    // MARK: - Private Functions
    
    private func clearForReuse() {
        characterName.text = nil
        characterImage.image = nil
        loveItButton.isFilled = false
        characterImage.cancel()
    }
    
    // MARK: - IBActions
    
    @IBAction func loveIt(_ sender: UIHeartButton) {
        guard let character = self.character else { return }
        loveItButton.toggleIt()
        character.isFavorite = loveItButton.isFilled
        delegate?.setFavorite(character)
    }
}
