//
//  CharacterWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

typealias CharacterWorkerSuccess = (_ response: CharacterListResponse?) -> Void
typealias CharacterWorkerError = (_ error: NetworkError?) -> Void

protocol CharacterWorkerProtocol {
    
    func getFavoriteCharacters() -> [Character]
    
    func saveFavorite(character: Character,
                      sucess: Completation?,
                      failure: Completation?)
    
    func deleteFavorite(character: Character,
                        sucess: Completation?,
                        failure: Completation?)
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError)
    
    func fetchCharacterList(searchParameter: String, offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError)
}

class CharacterWorker: CharacterWorkerProtocol {
    
    // MARK: - Private Properties
    
    private let networkManager: NetworkManagerProtocol
    
    private let characterPersistence: CharacterPersistenceProtocol
    
    // MARK: - Inits
    
    init() {
        self.networkManager = NetworkManager()
        self.characterPersistence = CharacterPersistence()
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
    
    func fetchCharacterList(searchParameter: String, offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError) {
        
        let url = MarvelURLBuilder(resource: .characters)
            .set(nameStartsWith: searchParameter)
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
    
    func getFavoriteCharacters() -> [Character] {
        return characterPersistence.getCharacters()
    }
    
    func saveFavorite(character: Character,
                      sucess: Completation?,
                      failure: Completation?) {
        
        characterPersistence.save(
            character: character,
            sucess: {
                sucess?()
            },
            failure: {
                failure?()
            })
    }
    
    func deleteFavorite(character: Character,
                        sucess: Completation?,
                        failure: Completation?) {
        
        characterPersistence.delete(
            character: character,
            sucess: {
                sucess?()
            },
            failure: {
                failure?()
            })
    }
}
