//
//  CharacterAdapter.swift
//  Marvel
//
//  Created by Ruan Reis on 31/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

typealias CharacterAdaptee = CharacterAdapter.Adaptee

class CharacterAdapter: Character {
    
    init(_ character: Adaptee) {
        super.init(
            id: character.identifier,
            name: character.name,
            description: character.about,
            isFavorite: character.isFavorite,
            thumbnail: Thumbnail(
                path: character.thumbnail?.path,
                extension: character.thumbnail?.extension))
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

extension CharacterAdapter: AdapterProtocol {
    
    typealias Adaptee = CharacterRealm
}
