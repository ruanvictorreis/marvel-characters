//
//  CharacterDetailsViewModel.swift
//  Marvel
//
//  Created by Ruan Reis on 12/11/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

struct CharacterDetailsViewModel {
    
    let name: String
    
    let description: String
    
    let image: String
    
    let isLoved: Bool
    
    let comics: [ComicViewModel]
}

struct ComicViewModel {
    
    let image: String
}
