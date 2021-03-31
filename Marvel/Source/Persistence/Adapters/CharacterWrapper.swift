//
//  CharacterWrapper.swift
//  Marvel
//
//  Created by Ruan Reis on 30/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterWrapperProtocol {
    
    func makePersistenceObject(_ character: Character) -> CharacterWrapper.PersistenceObject
    
    func makeResultForBusiness(_ procedure: () -> Result<CharacterWrapper.PersistenceObject, MarvelError>) -> CharacterResult
    
    func makeResultForBusiness(_ procedure: () -> Result<[CharacterWrapper.PersistenceObject], MarvelError>) -> CharacterListResult
}

class CharacterWrapper: CharacterWrapperProtocol {
    
    // MARK: - Typealias
    
    typealias PersistenceObject = CharacterRealm
    
    typealias PersistenceResult = Result<PersistenceObject, MarvelError>
    
    typealias PersistenceListResult = Result<[PersistenceObject], MarvelError>
    
    // MARK: - Public Functions
    
    func makePersistenceObject(_ character: Character) -> PersistenceObject {
        PersistenceObject(character)
    }
    
    func makeResultForBusiness(_ procedure: () -> PersistenceResult) -> CharacterResult {
        let result = procedure()
        
        switch result {
        case .success(let object):
            let character = initialize(object)
            return .success(character)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func makeResultForBusiness(_ procedure: () -> PersistenceListResult) -> CharacterListResult {
        let result = procedure()
        
        switch result {
        case .success(let objects):
            let characters = initialize(objects)
            return .success(characters)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    // MARK: - Private Functions
    
    private func initialize(_ objects: [PersistenceObject]) -> [Character] {
        objects.map { object in
            initialize(object)
        }
    }
    
    private func initialize(_ object: PersistenceObject) -> Character {
        Character(
            id: object.identifier,
            name: object.name,
            description: object.about,
            isFavorite: object.isFavorite,
            thumbnail: Thumbnail(
                path: object.thumbnail?.path,
                extension: object.thumbnail?.extension))
    }
}
