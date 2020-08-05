//
//  CharacterListViewControllerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

class CharacterListViewControllerMock: CharacterListViewControllerProtocol {
    
    var interactor: CharacterListInteractorProtocol!
    
    var characterList: [Character] = []
    
    var errorMessage: String = ""

    var showCharacterListCalled = false
    
    var showCharacterListErrorCalled = false
    
    var removeCharacterFromListCalled = false
    
    func showCharacterList(_ characters: [Character]) {
        characterList.append(contentsOf: characters)
        showCharacterListCalled = true
    }
    
    func showCharacterListError(_ errorMessage: String) {
        self.errorMessage = errorMessage
        showCharacterListErrorCalled = true
    }
    
    func removeCharacterFromList(_ character: Character) {
        characterList.removeAll(where: { $0.id == character.id })
        removeCharacterFromListCalled = true
    }
}
