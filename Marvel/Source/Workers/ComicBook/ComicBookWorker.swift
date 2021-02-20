//
//  ComicBookWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

typealias ComicBookCompletation = (Result<ComicBookListResponse?, MarvelError>) -> Void

protocol ComicBookWorkerProtocol {
    
    func fetchComicBookList(character: Int, completation: @escaping ComicBookCompletation)
}

class ComicBookWorker: ComicBookWorkerProtocol {
    
    // MARK: - Private Properties
    
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Inits
    
    init() {
        self.networkManager = NetworkManager()
    }
    
    // MARK: - Public Functions
    
    func fetchComicBookList(character: Int, completation: @escaping ComicBookCompletation) {
        let url = MarvelURLBuilder(resource: .comics)
            .set(characters: character)
            .build()
        
        let decoder = DefaultDecoder(for: ComicBookListResponse.self)
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
}
