//
//  RequestData.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

struct RequestData {
    
    var url: String
    
    var method: HTTPMethod
    
    var encoding: ParameterEncoding
    
    var parameters: [String: Any]?
    
}
