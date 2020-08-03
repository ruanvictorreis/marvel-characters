//
//  CharacterSection.swift
//  Marvel
//
//  Created by Ruan Reis on 02/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

enum CharacterSection: Int {
    case characters
    case favorites
    
    var title: String {
        switch self {
        case .characters:
            return R.Localizable.characters()
        case .favorites:
            return R.Localizable.favorites()
        }
    }
}
