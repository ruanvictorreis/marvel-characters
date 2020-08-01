//
//  PersistenceManager.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

typealias Completation = (() -> Void)?

protocol PersistenceManagerProtocol {
    
    func getCharacters() -> [Character]
    
    func save(character: Character, sucess: Completation, failure: Completation)
}

class PersistenceManager: PersistenceManagerProtocol {
    
    private let database: PersistenceProtocol
    
    init() {
        database = RealmDatabase()
    }
    
    func getCharacters() -> [Character] {
        return database.getCharacters()
    }
    
    func save(character: Character, sucess: Completation, failure: Completation) {
        database.save(character)
            ? sucess?()
            : failure?()
    }
}
