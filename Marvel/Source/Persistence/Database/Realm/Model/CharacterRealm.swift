//
//  CharacterRealm.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import RealmSwift

class CharacterRealm: Object {
    
    @objc dynamic var id = 0
    
    @objc dynamic var name: String = ""
    
    @objc dynamic var about: String = ""
    
    @objc dynamic var thumbnail: ThumbnailRealm?
    
    convenience init(character: Character) {
        self.init()
        self.id = character.id
        self.name = character.name
        self.about = character.description
        
        let thumbnail = character.thumbnail
        self.thumbnail = ThumbnailRealm(thumbnail: thumbnail)
    }
}
