//
//  MarvelAPI.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

enum MarvelResource: String {
    case characters
    case comics
    case events
    case series
    case stories
}

struct MarvelAPI {
    
    // MARK: - Internal Properties
    
    static var publicKey: String {
        Bundle.main.keys?["publicKey"] ?? ""
    }
    
    static var privateKey: String {
        Bundle.main.keys?["privateKey"] ?? ""
    }
    
    static let version: String = "v1"
    
    static let baseURL: String = "https://gateway.marvel.com:443/\(MarvelAPI.version)"
}
