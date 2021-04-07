//
//  CharacterWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

typealias CharactersCompletation = (Result<CharacterListResponse?, MarvelError>) -> Void

protocol CharacterWorkerProtocol {
    
    func getFavorites() -> Result<[Character], MarvelError>
    
    func saveFavorite(_ character: Character) -> Result<Character, MarvelError>
    
    func deleteFavorite(_ character: Character) -> Result<Character, MarvelError>
    
    func filterFavorites(byName name: String) -> Result<[Character], MarvelError>
    
    func fetchList(offset: Int, completation: @escaping CharactersCompletation)
    
    func fetchList(searchText: String, offset: Int, completation: @escaping CharactersCompletation)
}

class CharacterWorker: CharacterWorkerProtocol {
    
    // MARK: - Internal Typealias
    
    typealias CharacterAdaptee = CharacterAdapter.Adaptee
    
    typealias PersistenceResult = Result<CharacterAdaptee, MarvelError>
    
    typealias PersistenceListResult = Result<[CharacterAdaptee], MarvelError>
    
    // MARK: - Private Properties
    
    private let networkManager: NetworkManagerProtocol
    
    private let persistenceManager: PersistenceManagerProtocol
    
    // MARK: - Inits
    
    init() {
        self.networkManager = NetworkManager()
        self.persistenceManager = PersistenceManager()
    }
    
    // MARK: - Public Functions
    
    func fetchList(offset: Int, completation: @escaping CharactersCompletation) {
        let url = MarvelURLBuilder(resource: .characters)
            .set(offset: offset)
            .build()
        
        requestCharacters(url, completation: completation)
    }
    
    func fetchList(searchText: String, offset: Int, completation: @escaping CharactersCompletation) {
        let url = MarvelURLBuilder(resource: .characters)
            .set(nameStartsWith: searchText)
            .set(offset: offset)
            .build()
        
        requestCharacters(url, completation: completation)
    }
    
    func getFavorites() -> Result<[Character], MarvelError> {
        let result: PersistenceListResult = persistenceManager.getList()
        return makeResultForBusiness(result)
    }
    
    func saveFavorite(_ character: Character) -> Result<Character, MarvelError> {
        let object = CharacterAdaptee(character)
        let result = persistenceManager.save(object)
        return makeResultForBusiness(result)
    }
    
    func deleteFavorite(_ character: Character) -> Result<Character, MarvelError> {
        let object = CharacterAdaptee(character)
        let result = persistenceManager.delete(object)
        return makeResultForBusiness(result)
    }
    
    func filterFavorites(byName name: String) -> Result<[Character], MarvelError> {
        let result: PersistenceListResult = persistenceManager.filter(byName: name)
        return makeResultForBusiness(result)
    }
    
    // MARK: - Private Functions
    
    private func requestCharacters(_ url: String, completation: @escaping CharactersCompletation) {
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
    
    private func makeResultForBusiness(_ result: PersistenceResult) -> Result<Character, MarvelError> {
        switch result {
        case .success(let object):
            let character = applyAdapter(object)
            return .success(character)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func makeResultForBusiness(_ result: PersistenceListResult) -> Result<[Character], MarvelError> {
        switch result {
        case .success(let objects):
            let characters = applyAdapter(objects)
            return .success(characters)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func applyAdapter(_ objects: [CharacterAdaptee]) -> [Character] {
        return objects.map { object in
            applyAdapter(object)
        }
    }
    
    private func applyAdapter(_ object: CharacterAdaptee) -> Character {
        return CharacterAdapter(object)
    }
}
