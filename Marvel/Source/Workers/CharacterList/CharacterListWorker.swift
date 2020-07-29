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
    
    var currentPage: Int { get }
    
    func nextPage()
    
    func fetchCharacterList(sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError)
    
    func searchForCharacter(searchParameter: String,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError)
}

class CharacterListWorker: CharacterListWorkerProtocol {
    
    // MARK: - Private properties
    
    private let pageCount = 25
    
    // MARK: - Public properties
    
    var currentPage = 0
    
    // MARK: - Public function
    
    func fetchCharacterList(sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError) {
        
        let url = MarvelAPI.build(
            resource: .characters,
            offset: pageCount * currentPage)
        
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
    
    func searchForCharacter(searchParameter: String,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError) {
        
        let url = MarvelAPI.build(
            resource: .characters,
            searchParameter: searchParameter)
        
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
    
    func nextPage() {
        self.currentPage += 1
    }
}
