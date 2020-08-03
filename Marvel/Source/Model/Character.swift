//
//  Character.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class Character: Decodable, Equatable {
    
    let id: Int
    
    let name: String
    
    let description: String
    
    let thumbnail: Thumbnail
    
    var isFavorite: Bool = false
    
    private enum CodingKeys: CodingKey {
        case id, name, description, thumbnail
    }
    
    init(id: Int, name: String, description: String, isFavorite: Bool, thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.description = description
        self.isFavorite = isFavorite
        self.thumbnail = thumbnail
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}
