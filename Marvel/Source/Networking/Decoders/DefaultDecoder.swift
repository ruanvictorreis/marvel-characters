//
//  DefaultDecoder.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class DefaultDecoder<T: Decodable> {
    
    // MARK: - Internal properties
    
    internal let expectedType: T.Type
    
    // MARK: - Init
    
    init(for type: T.Type) {
        self.expectedType = type
    }
    
    // MARK: - Public functions
    
    func decode(from data: Data) -> T? {
        return try? JSONDecoder().decode(expectedType.self, from: data)
    }
}
