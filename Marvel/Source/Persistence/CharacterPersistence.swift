//
//  PersistenceManager.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterPersistenceProtocol {
    
    func getCharacters() -> Result<[Character], MarvelError>
    
    func save(_ character: Character) -> Result<Character, MarvelError>
    
    func delete(_ character: Character) -> Result<Character, MarvelError>
}

class CharacterPersistence: CharacterPersistenceProtocol {
    
    // MARK: - Private Properties
    
    private let database: RealmDatabaseProtocol
    
    // MARK: - Inits
    
    init() {
        database = RealmDatabase()
    }
    
    // MARK: - Public Functions
    
    func getCharacters() -> Result<[Character], MarvelError> {
        do {
            let results: [CharacterRealm] = try database.getAll()
            
            let characters =  results.map { object in
                build(character: object)
            }
            
            return .success(characters)
            
        } catch {
            return .failure(.networkError)
        }
    }
    
    func save(_ character: Character) -> Result<Character, MarvelError> {
        do {
            let object = CharacterRealm(character)
            try database.save(object)
            return .success(character)
            
        } catch {
            return .failure(.databaseError)
        }
    }
    
    func delete(_ character: Character) -> Result<Character, MarvelError> {
        do {
            guard let object: CharacterRealm = try database.get(character.id) else {
                return .failure(.databaseError)
            }
            
            try database.delete(object)
            return .success(character)
            
        } catch {
            return .failure(.databaseError)
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
