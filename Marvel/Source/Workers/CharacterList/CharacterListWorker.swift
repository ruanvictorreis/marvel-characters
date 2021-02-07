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
    
    private let characterPersistence: CharacterPersistenceProtocol
    
    // MARK: - Inits
    
    init() {
        self.characterPersistence = CharacterPersistence()
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
