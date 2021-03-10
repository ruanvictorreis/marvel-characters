//
//  CharacterListViewDelegate.swift
//  Marvel
//
//  Created by Ruan Reis on 10/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterListViewDelegate: AnyObject {
    
    var characterList: [CharacterViewModel] { get }
    
    func fetchCharacterNextPage()
    
    func selectCharacter(at index: Int)
}
