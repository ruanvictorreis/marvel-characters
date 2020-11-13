//
//  ComicBook.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

struct ComicBook: Decodable {
    
    // MARK: - Decodable Properties
    
    let id: Int
    
    let title: String
    
    let thumbnail: Thumbnail
    
    private enum CodingKeys: CodingKey {
        case id, title, thumbnail
    }
    
    // MARK: - Computed Properties
    
    var imageURL: String {
        "\(thumbnail.path).\(thumbnail.extension)"
    }
}
