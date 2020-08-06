//
//  PersistenceManager.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

typealias Completation = (() -> Void)

protocol PersistenceManagerProtocol {
    
    func getCharacters() -> [Character]
    
    func save(character: Character, sucess: Completation?, failure: Completation?)
    
    func delete(character: Character, sucess: Completation?, failure: Completation?)
}

class PersistenceManager: PersistenceManagerProtocol {
    
    // MARK: - Private Properties

    private let database: PersistenceProtocol
    
    // MARK: - Inits
    
    init() {
        database = RealmDatabase()
    }
    
    // MARK: - Public Functions
    
    func getCharacters() -> [Character] {
        return database.getCharacters()
    }
    
    func save(character: Character, sucess: Completation?, failure: Completation?) {
        database.save(character)
            ? sucess?()
            : failure?()
    }
    
    func delete(character: Character, sucess: Completation?, failure: Completation?) {
        database.delete(character)
            ? sucess?()
            : failure?()
    }
}
