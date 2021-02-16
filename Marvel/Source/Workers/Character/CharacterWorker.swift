//
//  CharacterWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

typealias CharacterWorkerSuccess = (_ response: CharacterListResponse?) -> Void

typealias CharacterWorkerError = (_ error: MarvelError) -> Void

protocol CharacterWorkerProtocol {
    
    func getFavoriteCharacters() -> Result<[Character], MarvelError>
    
    func saveFavorite(_ character: Character) -> Result<Character, MarvelError>
    
    func deleteFavorite(_ character: Character) -> Result<Character, MarvelError>
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError)
    
    func fetchCharacterList(searchText: String, offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError)
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
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError) {
        
        let url = MarvelURLBuilder(resource: .characters)
            .set(offset: offset)
            .build()
        
        let decoder = DefaultDecoder(for: CharacterListResponse.self)
        let request = NetworkRequest(url: url, method: .get, encoding: .JSON)
        
        networkManager.request(
            data: request,
            decoder: decoder,
            success: { response in
                sucess(response)
            },
            failure: { error in
                failure(error)
            })
    }
    
    func fetchCharacterList(searchText: String, offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError) {
        
        let url = MarvelURLBuilder(resource: .characters)
            .set(nameStartsWith: searchText)
            .set(offset: offset)
            .build()
        
        let decoder = DefaultDecoder(for: CharacterListResponse.self)
        let request = NetworkRequest(url: url, method: .get, encoding: .JSON)
        
        networkManager.request(
            data: request,
            decoder: decoder,
            success: { response in
                sucess(response)
            },
            failure: { error in
                failure(error)
            })
    }
    
    func getFavoriteCharacters() -> Result<[Character], MarvelError> {
        let result: Result<[CharacterRealm], MarvelError> = persistenceManager.getAll()
        
        switch result {
        case .success(let objects):
            return .success(build(objects))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func saveFavorite(_ character: Character) -> Result<Character, MarvelError> {
        let object = CharacterRealm(character)
        let result = persistenceManager.save(object)
        
        switch result {
        case .success:
            return .success(character)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteFavorite(_ character: Character) -> Result<Character, MarvelError> {
        let object = CharacterRealm(character)
        let result = persistenceManager.delete(object)
        
        switch result {
        case .success:
            return .success(character)
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
