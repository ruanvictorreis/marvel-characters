//
//  SnakeCaseDecoder.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class SnakeCaseDecoder<T: Decodable>: DefaultDecoder<T> {
        
    // MARK: - Public functions
    
    override func decode(from data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(expectedType.self, from: data)
    }
}
