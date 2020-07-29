//
//  CharacterListData.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

struct CharacterListResults: Decodable {
    
    let offset: Int
    
    let limit: Int
    
    let total: Int
    
    let count: Int
    
    let results: [Character]
    
}
