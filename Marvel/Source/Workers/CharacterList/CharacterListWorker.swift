//
//  CharacterListWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

typealias CharacterListSuccess = (_ response: CharacterListResponse?) -> Void
typealias CharacterListError = (_ error: AFError?) -> Void

protocol CharacterListWorkerProtocol {
    
    func getFavoriteCharacters() -> [Character]
    
    func saveFavorite(character: Character,
                      sucess: Completation?,
                      failure: Completation?)
    
    func deleteFavorite(character: Character,
                        sucess: Completation?,
                        failure: Completation?)
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError)
    
    func fetchCharacterList(searchParameter: String, offset: Int,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError)
}

class CharacterListWorker: CharacterListWorkerProtocol {
    
    // MARK: - Private Properties
    
    private let persistenceManager: PersistenceManagerProtocol
    
    // MARK: - Inits
    
    init() {
        self.persistenceManager = PersistenceManager()
    }
    
    // MARK: - Public Functions
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError) {
        
        let url = MarvelURLBuilder(resource: .characters)
            .set(offset: offset)
            .build()
        
        let enconding = JSONEncoding.default
        let decoder = DefaultDecoder(for: CharacterListResponse.self)
        let request = RequestData(url: url, method: .get, encoding: enconding)
        
        Network.request(
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
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError) {
        
        let url = MarvelURLBuilder(resource: .characters)
            .set(nameStartsWith: searchParameter)
            .set(offset: offset)
            .build()
        
        let enconding = JSONEncoding.default
        let decoder = DefaultDecoder(for: CharacterListResponse.self)
        let request = RequestData(url: url, method: .get, encoding: enconding)
        
        Network.request(
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
        return persistenceManager.getCharacters()
    }
    
    func saveFavorite(character: Character,
                      sucess: Completation?,
                      failure: Completation?) {
        
        persistenceManager.save(
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
        
        persistenceManager.delete(
            character: character,
            sucess: {
                sucess?()
            },
            failure: {
                failure?()
            })
    }
}
