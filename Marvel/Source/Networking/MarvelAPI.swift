//
//  MarvelAPI.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

struct MarvelAPI {

    // MARK: - Internal Properties
    
    static let version: String = "v1"
    static let publicKey: String = "e4ef626c97f6855f275df4f0f08eb5bb"
    static let privateKey: String = "a44cb5dff01f02f3314e0f01bb3d89ef88057a8d"
    static let baseURL: String = "https://gateway.marvel.com:443/\(MarvelAPI.version)"
    
    static func build(section: Section, limit: Int) -> String {
        let timeStamp = Date().toMillisString()
        let hash = timeStamp + MarvelAPI.privateKey + MarvelAPI.publicKey
        
        return "\(MarvelAPI.baseURL)/public/\(section.rawValue)"
            + "?hash=\(hash.md5)&ts=\(timeStamp)&limit=\(limit)"
            + "&apikey=\(MarvelAPI.publicKey)"
    }
}
