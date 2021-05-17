//
//  NetworkManager.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

typealias NetworkResult<T: Decodable> = ((Result<T?, MarvelError>) -> Void)

protocol NetworkManagerProtocol {
    
    func request<T: Decodable>(_ data: NetworkRequest, completion:  @escaping NetworkResult<T>)
}

class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Public Functions
    
    func request<T: Decodable>(_ data: NetworkRequest, completion: @escaping NetworkResult<T>) {
        let decoder = JSONDecoder()
        let request = AF.request(
            data.url,
            method: data.method.httpMethod,
            parameters: data.parameters,
            encoding: data.encoding.default)
        
        request.validate().responseJSON { response in
            switch response.result {
            case .success:
                let data = response.data ?? Data()
                let result = try? decoder
                    .decode(T.self, from: data)
                completion(.success(result))
            case .failure:
                completion(.failure(.networkError))
            }
        }
    }
}
