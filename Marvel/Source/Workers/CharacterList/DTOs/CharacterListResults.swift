//
//  CharacterListResults.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

struct CharacterListResults: Decodable {
    
    var offset: Int
    
    var limit: Int
    
    var total: Int
    
    var count: Int
    
    var results: [Character]
}
