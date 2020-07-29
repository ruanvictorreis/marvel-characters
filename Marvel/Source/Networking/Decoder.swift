//
//  Decoder.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class Decoder<T: Decodable> {
    
    // MARK: - Private properties
    
    private var expectation: T.Type
    
    // MARK: - Init
    
    init(expectation: T.Type) {
        self.expectation = expectation
    }
    
    // MARK: - Public functions
    
    func decode(from data: Data) -> T? {
        return try? JSONDecoder().decode(expectation.self, from: data)
    }
}
