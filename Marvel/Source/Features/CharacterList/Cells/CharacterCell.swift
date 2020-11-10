//
//  CharacterCollectionCell.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterCellDelegate: AnyObject {
    
    func setFavorite(_ cell: UICollectionViewCell, toggle: Bool)
}

class CharacterCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var characterName: UILabel!
    
    @IBOutlet private var characterImage: UIImageView!
    
    @IBOutlet private var loveItButton: UIHeartButton!
    
    // MARK: - Public Properties
    
    weak var delegate: CharacterCellDelegate?
    
    static let identifier = String(describing: CharacterCell.self)
    
    // MARK: - Public Functions
    
    override func prepareForReuse() {
        clearForReuse()
    }
    
    func setup(_ character: Character) {
        characterName.text = character.name
        characterImage.load(url: character.imageURL)
        loveItButton.isFilled = character.isFavorite
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
        
        let toggle = loveItButton.isFilled
        delegate?.setFavorite(self, toggle: toggle)
    }
}
