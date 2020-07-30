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
    
    static let version: String = "v1"
    
    static let publicKey: String = "e4ef626c97f6855f275df4f0f08eb5bb"
    
    static let privateKey: String = "a44cb5dff01f02f3314e0f01bb3d89ef88057a8d"
    
    static let baseURL: String = "https://gateway.marvel.com:443/\(MarvelAPI.version)"
}
