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
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError)
    
    func fetchCharacterList(searchParameter: String, offset: Int,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError)
}

class CharacterListWorker: CharacterListWorkerProtocol {
        
    // MARK: - Public Function
    
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
        return PersistenceManager().getCharacters()
    }
    
    func saveFavorite(character: Character,
                      sucess: Completation?,
                      failure: Completation?) {
        
        PersistenceManager().save(
            character: character,
            sucess: {
                sucess?()
            },
            failure: {
                failure?()
            })
    }
}
