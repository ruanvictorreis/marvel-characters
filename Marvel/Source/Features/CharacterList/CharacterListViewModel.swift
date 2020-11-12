//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Ruan Reis on 12/11/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

struct CharacterListViewModel {
    
    let characters: [CharacterViewModel]
}

struct CharacterViewModel {
    
    let name: String
    
    let image: String
    
    let isLoved: Bool
}
