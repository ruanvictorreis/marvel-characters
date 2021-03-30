//
//  CharacterRealm.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import RealmSwift

class CharacterRealm: StorableObject {
    
    @objc dynamic var name: String = ""
    
    @objc dynamic var about: String = ""
    
    @objc dynamic var isFavorite: Bool = false
    
    @objc dynamic var thumbnail: ThumbnailRealm?
    
    var character: Character {
        Character(
            id: identifier,
            name: name,
            description: about,
            isFavorite: isFavorite,
            thumbnail: Thumbnail(
                path: thumbnail?.path,
                extension: thumbnail?.extension))
    }
    
    convenience init(_ character: Character) {
        self.init(character.id)
        self.name = character.name
        self.about = character.description
        self.isFavorite = character.isFavorite
        
        let thumbnail = character.thumbnail
        self.thumbnail = ThumbnailRealm(thumbnail)
    }
}
