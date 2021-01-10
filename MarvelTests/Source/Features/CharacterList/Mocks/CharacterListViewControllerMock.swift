//
//  CharacterListViewControllerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
@testable import Marvel

class CharacterListViewControllerMock: CharacterListViewControllerProtocol {
    
    var interactor: CharacterListInteractorProtocol!
    
    var characterList: [CharacterViewModel] = []
    
    var errorMessage: String = ""
    
    var showCharacterListCalled = false
    
    var showCharacterListErrorCalled = false
    
    var removeCharacterFromListCalled = false
    
    func showCharacterList(_ viewModel: CharacterListViewModel) {
        characterList.append(contentsOf: viewModel.characters)
        showCharacterListCalled = true
    }
    
    func reloadCharacters(_ viewModel: CharacterListViewModel, animated: Bool) {
        characterList = viewModel.characters
    }
    
    func removeCharacter(at indexPath: IndexPath) {
        characterList.remove(at: indexPath.item)
        removeCharacterFromListCalled = true
    }
    
    func showCharacterListError(_ errorMessage: String) {
        self.errorMessage = errorMessage
        showCharacterListErrorCalled = true
    }
}
