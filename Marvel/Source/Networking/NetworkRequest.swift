//
//  NetworkRequest.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

struct NetworkRequest {
    
    var url: String
    
    var method: NetworkMethod
    
    var encoding: NetworkEncoding
    
    var parameters: [String: Any]?
}
