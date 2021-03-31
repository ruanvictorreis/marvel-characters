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
    
    func fetchList(offset: Int, completation: @escaping CharacterCompletation)
    
    func fetchList(searchText: String, offset: Int, completation: @escaping CharacterCompletation)
}

class CharacterWorker: CharacterWorkerProtocol {
    
    // MARK: - Private Properties
    
    private let networkManager: NetworkManagerProtocol
    
    private let characterWrapper: CharacterWrapperProtocol
    
    private let persistenceManager: PersistenceManagerProtocol
    
    // MARK: - Inits
    
    init() {
        self.networkManager = NetworkManager()
        self.characterWrapper = CharacterWrapper()
        self.persistenceManager = PersistenceManager()
    }
    
    // MARK: - Public Functions
    
    func fetchList(offset: Int, completation: @escaping CharacterCompletation) {
        let url = MarvelURLBuilder(resource: .characters)
            .set(offset: offset)
            .build()
        
        requestCharacters(url, completation: completation)
    }
    
    func fetchList(searchText: String, offset: Int, completation: @escaping CharacterCompletation) {
        let url = MarvelURLBuilder(resource: .characters)
            .set(nameStartsWith: searchText)
            .set(offset: offset)
            .build()
        
        requestCharacters(url, completation: completation)
    }
    
    func getFavorites() -> CharacterListResult {
        return characterWrapper.makeResult {
            persistenceManager.getList()
        }
    }
    
    func saveFavorite(_ character: Character) -> CharacterResult {
        let object = characterWrapper
            .makePersistenceObject(character)
        
        return characterWrapper.makeResult {
            persistenceManager.save(object)
        }
    }
    
    func deleteFavorite(_ character: Character) -> CharacterResult {
        let object = characterWrapper
            .makePersistenceObject(character)
        
        return characterWrapper.makeResult {
            persistenceManager.delete(object)
        }
    }
    
    func filterFavorites(byName name: String) -> CharacterListResult {
        return characterWrapper.makeResult {
            persistenceManager.filter(byName: name)
        }
    }
    
    // MARK: - Private Functions
    
    private func requestCharacters(_ url: String, completation: @escaping CharacterCompletation) {
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
}
