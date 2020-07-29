//
//  Network.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

typealias RequestSuccess<T: Decodable> = (_ result: T?) -> Void
typealias RequestFailure = (_ error: AFError?) -> Void

protocol Networking {
    
    func request<T: Decodable>(data: RequestData,
                               decoder: Decoder<T>,
                               success: @escaping RequestSuccess<T>,
                               failure: @escaping RequestFailure)
}

class Network: Networking {
    
    func request<T: Decodable>(data: RequestData,
                               decoder: Decoder<T>,
                               success: @escaping RequestSuccess<T>,
                               failure: @escaping RequestFailure) {
        
        let request = AF.request(data.url, method: data.method,
                                 parameters: data.parameters,
                                 encoding: data.encoding)
        
        request.validate().responseJSON { response in
            switch response.result {
            case .success:
                let data = response.data ?? Data()
                success(decoder.decode(from: data))
            case .failure:
                failure(response.error)
            }
        }
    }
}
