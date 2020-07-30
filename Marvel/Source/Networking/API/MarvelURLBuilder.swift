//
//  MarvelURLBuilder.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class MarvelURLBuilder {
    
    private var url: String
    
    init(resource: MarvelResource) {
        self.url = "\(MarvelAPI.baseURL)/public/\(resource.rawValue)"
        setup()
    }
    
    private func setup() {
        let apiKey = MarvelAPI.publicKey
        let privateKey = MarvelAPI.privateKey
        let timeStamp = Date().toMillisString()
        let hash = (timeStamp + privateKey + apiKey).md5
        self.url += "?apikey=\(apiKey)&hash=\(hash)&ts=\(timeStamp)"
    }
    
    func set(offset: Int) -> MarvelURLBuilder {
        self.url += "&offset=\(offset)"
        return self
    }
    
    func set(nameStartsWith: String) -> MarvelURLBuilder {
        self.url += "&nameStartsWith=\(nameStartsWith.percentEncoding)"
        return self
    }
    
    func build() -> String {
        return url
    }
}
