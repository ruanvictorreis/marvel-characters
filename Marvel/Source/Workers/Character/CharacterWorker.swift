//
//  CharacterWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

typealias CharacterResult = Result<Character, MarvelError>

typealias CharacterListResult = Result<[Character], MarvelError>

typealias CharacterCompletation = (Result<CharacterListResponse?, MarvelError>) -> Void

protocol CharacterWorkerProtocol {
    
    func getFavorites() -> CharacterListResult
    
    func saveFavorite(_ character: Character) -> CharacterResult
    
    func deleteFavorite(_ character: Character) -> CharacterResult
    
    func filterFavorites(byName name: String) -> CharacterListResult
    
    func fetchCharacterList(offset: Int, completation: @escaping CharacterCompletation)
    
    func fetchCharacterList(searchText: String, offset: Int, completation: @escaping CharacterCompletation)
}

class CharacterWorker: CharacterWorkerProtocol {
    
    // MARK: - Private Properties
    
    private let networkManager: NetworkManagerProtocol
    
    private let persistenceManager: PersistenceManagerProtocol
    
    // MARK: - Inits
    
    init() {
        self.networkManager = NetworkManager()
        self.persistenceManager = PersistenceManager()
    }
    
    // MARK: - Public Functions
    
    func fetchCharacterList(offset: Int, completation: @escaping CharacterCompletation) {
        let url = MarvelURLBuilder(resource: .characters)
            .set(offset: offset)
            .build()
        
        let decoder = DefaultDecoder(for: CharacterListResponse.self)
        let request = NetworkRequest(url: url, method: .get, encoding: .JSON)
        
        networkManager.request(request, decoder: decoder) { result in
            switch result {
            case .success(let response):
                completation(.success(response))
            case .failure(let error):
                completation(.failure(error))
            }
        }
    }
    
    func fetchCharacterList(searchText: String, offset: Int, completation: @escaping CharacterCompletation) {
        let url = MarvelURLBuilder(resource: .characters)
            .set(nameStartsWith: searchText)
            .set(offset: offset)
            .build()
        
        let decoder = DefaultDecoder(for: CharacterListResponse.self)
        let request = NetworkRequest(url: url, method: .get, encoding: .JSON)
        
        networkManager.request(request, decoder: decoder) { result in
            switch result {
            case .success(let response):
                completation(.success(response))
            case .failure(let error):
                completation(.failure(error))
            }
        }
    }
    
    func getFavorites() -> CharacterListResult {
        let result: Result<[CharacterRealm], MarvelError>
        result = persistenceManager.getAll()
        
        switch result {
        case .success(let objects):
            let characters = build(objects)
            return .success(characters)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func saveFavorite(_ character: Character) -> CharacterResult {
        let object = CharacterRealm(character)
        let result = persistenceManager.save(object)
        
        switch result {
        case .success:
            return .success(character)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteFavorite(_ character: Character) -> CharacterResult {
        let object = CharacterRealm(character)
        let result = persistenceManager.delete(object)
        
        switch result {
        case .success:
            return .success(character)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func filterFavorites(byName name: String) -> CharacterListResult {
        let result: Result<[CharacterRealm], MarvelError>
        result = persistenceManager.filter(byName: name)
        
        switch result {
        case .success(let objects):
            let characters = build(objects)
            return .success(characters)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    // MARK: - Private Functions
    
    private func build(_ characters: [CharacterRealm]) -> [Character] {
        characters.map { character in
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
}
