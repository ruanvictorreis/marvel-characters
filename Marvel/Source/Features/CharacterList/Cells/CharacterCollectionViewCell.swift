//
//  CharacterCollectionViewCell.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet private var characterName: UILabel!
    
    @IBOutlet private var characterImage: UIImageView!
    
    override func prepareForReuse() {
        clearForReuse()
    }
    
    func setup(character: Character) {
//        characterName.text = character.name
        let thumbnail = character.thumbnail
        let imageUrl = "\(thumbnail.path).\(thumbnail.extension)"
        characterImage.load(url: imageUrl)
    }
    
    private func clearForReuse() {
//        characterName.text = nil
        characterImage.cancel()
    }
}
