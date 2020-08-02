//
//  PersistenceProtocol.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol PersistenceProtocol {
    
    func getCharacters() -> [Character]
    
    func save(_ character: Character) -> Bool
    
    func delete(_ character: Character) -> Bool
}
