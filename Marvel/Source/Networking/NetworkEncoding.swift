//
//  NetworkEncoding.swift
//  Marvel
//
//  Created by Ruan Reis on 07/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Alamofire

enum NetworkEncoding {
    case URL
    case JSON
    
    var `default`: ParameterEncoding {
        switch self {
        case .URL:
            return URLEncoding.default
        case .JSON:
            return JSONEncoding.default
        }
    }
}
