//
//  ComicBook.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

struct ComicBook: Decodable {
    
    let id: Int
    
    let title: String
    
    let thumbnail: Thumbnail
}
