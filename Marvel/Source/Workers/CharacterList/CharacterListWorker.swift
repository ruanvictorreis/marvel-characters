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
    
    func restart()
    
    func nextPage()
    
    func shouldFetchNewPage() -> Bool
    
    func getFavoriteCharacters() -> [Character]
    
    func saveFavorite(character: Character,
                      sucess: Completation,
                      failure: Completation)
    
    func fetchCharacterList(sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError)
    
    func fetchCharacterList(searchParameter: String,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError)
}

class CharacterListWorker: CharacterListWorkerProtocol {

    // MARK: - Private Properties
    
    private var totalCount = 0
    
    private var currentPage = 0
    
    private let pageCount = 20
    
    // MARK: - Public Function
    
    func fetchCharacterList(sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError) {
        
        let url = MarvelURLBuilder(resource: .characters)
            .set(offset: currentPage * pageCount)
            .build()
        
        let enconding = JSONEncoding.default
        let decoder = DefaultDecoder(for: CharacterListResponse.self)
        let request = RequestData(url: url, method: .get, encoding: enconding)
        
        Network.request(
            data: request,
            decoder: decoder,
            success: { [weak self] response in
                sucess(response)
                self?.totalCount = response?.data.total ?? 0
            },
            failure: { error in
                failure(error)
            })
    }
    
    func fetchCharacterList(searchParameter: String,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError) {
        
        let url = MarvelURLBuilder(resource: .characters)
            .set(nameStartsWith: searchParameter)
            .set(offset: currentPage * pageCount)
            .build()
        
        let enconding = JSONEncoding.default
        let decoder = DefaultDecoder(for: CharacterListResponse.self)
        let request = RequestData(url: url, method: .get, encoding: enconding)
        
        Network.request(
            data: request,
            decoder: decoder,
            success: { [weak self] response in
                sucess(response)
                self?.totalCount = response?.data.total ?? 0
            },
            failure: { error in
                failure(error)
            })
    }
    
    func getFavoriteCharacters() -> [Character] {
        return PersistenceManager().getCharacters()
    }
    
    func saveFavorite(character: Character,
                      sucess: Completation,
                      failure: Completation) {
        
        PersistenceManager().save(
            character: character,
            sucess: {
                sucess?()
            },
            failure: {
                failure?()
            })
    }
    
    func shouldFetchNewPage() -> Bool {
        let isFirstFetch = totalCount == 0
        let shouldFetchMore = (currentPage + 1) * pageCount < totalCount
        return isFirstFetch || shouldFetchMore
    }
    
    func nextPage() {
        currentPage += 1
    }
    
    func restart() {
        totalCount = 0
        currentPage = 0
    }
}
