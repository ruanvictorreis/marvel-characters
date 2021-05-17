//
//  ComicBookWorker.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

typealias ComicBookCompletion = (Result<ComicBookListResponse?, MarvelError>) -> Void

protocol ComicBookWorkerProtocol {
    
    func fetchList(character: Int, completion: @escaping ComicBookCompletion)
}

class ComicBookWorker: ComicBookWorkerProtocol {
    
    // MARK: - Private Properties
    
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Inits
    
    init() {
        self.networkManager = NetworkManager()
    }
    
    // MARK: - Public Functions
    
    func fetchList(character: Int, completion: @escaping ComicBookCompletion) {
        let url = MarvelURLBuilder(resource: .comics)
            .set(characters: character)
            .build()
        
        let request = NetworkRequest(url: url, method: .get, encoding: .JSON)
        
        networkManager.request(request) { (result: Result<ComicBookListResponse?, MarvelError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
