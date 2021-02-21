//
//  NetworkManager.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

typealias RequestSuccess<T: Decodable> = (_ result: T?) -> Void
typealias RequestFailure = (_ error: MarvelError) -> Void

protocol NetworkManagerProtocol {
    
    func request<T: Decodable>(data: NetworkRequest,
                               decoder: DefaultDecoder<T>,
                               success: @escaping RequestSuccess<T>,
                               failure: @escaping RequestFailure)
}

class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Inits
    
    init() {}
    
    // MARK: - Public Functions
    
    func request<T: Decodable>(data: NetworkRequest,
                               decoder: DefaultDecoder<T>,
                               success: @escaping RequestSuccess<T>,
                               failure: @escaping RequestFailure) {
        
        let request = AF.request(
            data.url,
            method: data.method.httpMethod,
            parameters: data.parameters,
            encoding: data.encoding.default)
        
        request.validate().responseJSON { response in
            switch response.result {
            case .success:
                let data = response.data ?? Data()
                success(decoder.decode(from: data))
            case .failure:
                failure(.networkError)
            }
        }
    }
}
