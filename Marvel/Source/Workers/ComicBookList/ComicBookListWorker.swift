//
//  ComicBookListWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

typealias ComicBookListSuccess = (_ response: ComicBookListResponse?) -> Void
typealias ComicBookListError = (_ error: AFError?) -> Void

protocol ComicBookListWorkerProtocol {
    
    func fetchComicBookList(character: Int,
                            sucess: @escaping ComicBookListSuccess,
                            failure: @escaping ComicBookListError)
}

class ComicBookListWorker: ComicBookListWorkerProtocol {
    
    func fetchComicBookList(character: Int,
                            sucess: @escaping ComicBookListSuccess,
                            failure: @escaping ComicBookListError) {
        
        let url = MarvelURLBuilder(resource: .comics)
            .set(characters: character)
            .build()
        
        let enconding = JSONEncoding.default
        let decoder = DefaultDecoder(for: ComicBookListResponse.self)
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
}
