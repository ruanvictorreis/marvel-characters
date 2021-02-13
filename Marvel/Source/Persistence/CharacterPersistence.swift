//
//  PersistenceManager.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterPersistenceProtocol {
    
    func getCharacters() -> [Character]
    
    func save(_ character: Character, completation: CharacterDatabaseCompletation)
    
    func delete(_ character: Character, completation: CharacterDatabaseCompletation)
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
        do {
            let results: [CharacterRealm] = try database.getAll()
            return results.map { object in
                build(character: object)
            }
            
        } catch {
            return []
        }
    }
    
    func save(_ character: Character, completation: CharacterDatabaseCompletation) {
        do {
            let object = CharacterRealm(character)
            try database.save(object)
            completation(.success(character))
            
        } catch {
            completation(.failure(.databaseError))
        }
    }
    
    func delete(_ character: Character, completation: CharacterDatabaseCompletation) {
        do {
            guard let object: CharacterRealm = try database.get(character.id)
            else { return }
            
            try database.delete(object)
            completation(.success(character))
            
        } catch {
            completation(.failure(.databaseError))
        }
    }
    
    // MARK: - Private Functions
    
    private func build(character: CharacterRealm) -> Character {
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
