//
//  MarvelURLBuilder.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class MarvelURLBuilder {
    
    // MARK: - Private Properties
    
    private var url: String
    
    // MARK: - Inits
    
    init(resource: MarvelResource) {
        self.url = "\(MarvelAPI.baseURL)/public/\(resource.rawValue)"
        setupURL()
    }
    
    // MARK: - Public Functions
    
    func set(offset: Int) -> MarvelURLBuilder {
        self.url += "&offset=\(offset)"
        return self
    }
    
    func set(nameStartsWith: String) -> MarvelURLBuilder {
        self.url += "&nameStartsWith=\(nameStartsWith.percentEncoding)"
        return self
    }
    
    func set(characters: Int) -> MarvelURLBuilder {
        self.url += "&characters=\(characters)"
        return self
    }
    
    func build() -> String {
        return url
    }
    
    // MARK: - Private Functions
    
    private func setupURL() {
        let apiKey = MarvelAPI.publicKey
        let privateKey = MarvelAPI.privateKey
        let timeStamp = Date().toMillisString()
        let hash = (timeStamp + privateKey + apiKey).md5
        self.url += "?apikey=\(apiKey)&hash=\(hash)&ts=\(timeStamp)"
    }
}
