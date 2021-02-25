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
    
    func request<T: Decodable>(_ data: NetworkRequest, decoder: DefaultDecoder<T>, completation:  @escaping NetworkResult<T>)
}

class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Inits
    
    init() {}
    
    // MARK: - Public Functions
    
    func request<T: Decodable>(_ data: NetworkRequest, decoder: DefaultDecoder<T>, completation: @escaping NetworkResult<T>) {
        let request = AF.request(
            data.url,
            method: data.method.httpMethod,
            parameters: data.parameters,
            encoding: data.encoding.default)
        
        request.validate().responseJSON { response in
            switch response.result {
            case .success:
                let data = response.data ?? Data()
                let result = decoder.decode(from: data)
                completation(.success(result))
            case .failure:
                completation(.failure(.networkError))
            }
        }
    }
}
