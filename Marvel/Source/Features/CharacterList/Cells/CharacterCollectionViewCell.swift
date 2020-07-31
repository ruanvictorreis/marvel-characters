//
//  CharacterCollectionViewCell.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var characterName: UILabel!
    
    @IBOutlet private var characterImage: UIImageView!
    
    @IBOutlet private var loveItButton: UIHeartButton!
    
    // MARK: - IBActions
    
    @IBAction func loveIt(_ sender: UIHeartButton) {
        loveItButton.toggleIt()
    }
    
    // MARK: - Public Functions
    
    override func prepareForReuse() {
        clearForReuse()
    }
    
    func setup(character: Character) {
        characterName.text = character.name
        let thumbnail = character.thumbnail
        let imageUrl = "\(thumbnail.path).\(thumbnail.extension)"
        characterImage.load(url: imageUrl)
    }
    
    // MARK: - Private Functions
    
    private func clearForReuse() {
        characterName.text = nil
        characterImage.image = nil
        characterImage.cancel()
    }
}
