//
//  ComicBookWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

typealias ComicBookWorkerSuccess = (_ response: ComicBookListResponse?) -> Void
typealias ComicBookWorkerError = (_ error: MarvelError) -> Void

protocol ComicBookWorkerProtocol {
    
    func fetchComicBookList(character: Int,
                            sucess: @escaping ComicBookWorkerSuccess,
                            failure: @escaping ComicBookWorkerError)
}

class ComicBookWorker: ComicBookWorkerProtocol {
    
    // MARK: - Private Properties
    
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Inits
    
    init() {
        self.networkManager = NetworkManager()
    }
    
    // MARK: - Public Functions
    
    func fetchComicBookList(character: Int,
                            sucess: @escaping ComicBookWorkerSuccess,
                            failure: @escaping ComicBookWorkerError) {
        
        let url = MarvelURLBuilder(resource: .comics)
            .set(characters: character)
            .build()
        
        let decoder = DefaultDecoder(for: ComicBookListResponse.self)
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
}