//
//  Character.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class Character: Decodable, Equatable {
    
    // MARK: - Decodable Properties
    
    let id: Int
    
    let name: String
    
    let description: String
    
    let thumbnail: Thumbnail
    
    var isFavorite: Bool = false
    
    private enum CodingKeys: CodingKey {
        case id, name, description, thumbnail
    }
    
    // MARK: - Computed Properties
    
    var imageURL: String {
        let path = thumbnail.path ?? ""
        let `extension` = thumbnail.extension ?? ""
        return "\(path).\(`extension`)"
    }
    
    // MARK: - Init
    
    init(id: Int, name: String, description: String, isFavorite: Bool, thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.description = description
        self.isFavorite = isFavorite
        self.thumbnail = thumbnail
    }
    
    // MARK: - Equatable Protocol
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}
