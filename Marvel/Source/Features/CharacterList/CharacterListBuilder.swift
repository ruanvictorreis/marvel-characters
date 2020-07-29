//
//  CharacterListBuilder.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class CharacterListBuilder {
    
    func build() -> CharacterListViewController? {
        return R.storyboard.main.characterList()
    }
}
