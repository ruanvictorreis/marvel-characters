//
//  MarvelError.swift
//  Marvel
//
//  Created by Ruan Reis on 06/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

enum MarvelError: Error {
    case networkError
    case databaseError
}

extension MarvelError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return R.Localizable.networkError()
        case .databaseError:
            return R.Localizable.databaseError()
        }
    }
}
