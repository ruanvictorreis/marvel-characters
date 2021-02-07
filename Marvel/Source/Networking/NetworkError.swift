//
//  NetworkError.swift
//  Marvel
//
//  Created by Ruan Reis on 06/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

struct NetworkError: Error {
    
    let message: String?
    
    init(_ message: String?) {
        self.message = message
    }
}
