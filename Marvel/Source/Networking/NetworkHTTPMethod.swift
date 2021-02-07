//
//  NetworkHTTPMethod.swift
//  Marvel
//
//  Created by Ruan Reis on 07/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Alamofire

enum NetworkMethod {
    case get
    case post
    case put
    case patch
    case delete
    
    var httpMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .patch:
            return .patch
        case .delete:
            return .delete
        }
    }
}
