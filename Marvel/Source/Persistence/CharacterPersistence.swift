//
//  PersistenceManager.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

typealias Completation = (() -> Void)

protocol CharacterPersistenceProtocol {
    
    func getCharacters() -> [Character]
    
    func save(character: Character, completation: (Result<Int, MarvelError>) -> Void)
    
    func delete(character: Character, sucess: Completation?, failure: Completation?)
}

class CharacterPersistence: CharacterPersistenceProtocol {
    
    // MARK: - Private Properties
    
    private let database: RealmDatabaseProtocol
    
    // MARK: - Inits
    
    init() {
        database = RealmDatabase()
    }
    
    // MARK: - Public Functions
    
    func getCharacters() -> [Character] {
        let results: [CharacterRealm] = database.getAll()
        
        return results.map { character in
            Character(
                id: character.id,
                name: character.name,
                description: character.about,
                isFavorite: character.isFavorite,
                thumbnail: Thumbnail(
                    path: character.thumbnail?.path,
                    extension: character.thumbnail?.extension)
            )
        }
    }
    
    func save(character: Character, completation: (Result<Int, MarvelError>) -> Void) {
        do {
            let object = CharacterRealm(character)
            try database.save(object)
            completation(.success(object.id))
        } catch {
            completation(.failure(.databaseError))
        }
    }
    
    func delete(character: Character, sucess: Completation?, failure: Completation?) {
        guard let object: CharacterRealm = database.get(character.id) else { return }
        
        do {
            try database.delete(object)
            sucess?()
        } catch {
            failure?()
        }
    }
}
