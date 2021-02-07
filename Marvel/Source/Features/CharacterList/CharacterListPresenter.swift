//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterListPresenterProtocol {
    
    func showCharacterList(_ characters: [Character])
    
    func removeCharacterFromList(at index: Int)
    
    func showCharacterListError(_ error: NetworkError?)
    
    func reloadCharacters(_ characters: [Character], animated: Bool)
}

class CharacterListPresenter: CharacterListPresenterProtocol {
    
    // MARK: - VIP Properties
    
    weak var viewController: CharacterListViewControllerProtocol!
    
    // MARK: - Public Functions
    
    func showCharacterList(_ characters: [Character]) {
        let viewModel = buildViewModel(characters)
        viewController.showCharacterList(viewModel)
    }
    
    func reloadCharacters(_ characters: [Character], animated: Bool) {
        let viewModel = buildViewModel(characters)
        viewController.reloadCharacters(viewModel, animated: animated)
    }
    
    func showCharacterListError(_ error: NetworkError? = nil) {
        let errorMessage = error?.message ?? R.Localizable.errorDescription()
        viewController.showCharacterListError(errorMessage)
    }
    
    func removeCharacterFromList(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        viewController.removeCharacter(at: indexPath)
    }
    
    // MARK: - Private Functions
    
    private func buildViewModel(_ results: [Character]) -> CharacterListViewModel {
        let characters = results.map { char in
            CharacterViewModel(
                name: char.name,
                image: char.imageURL,
                isLoved: char.isFavorite)
        }
        
        return CharacterListViewModel(characters: characters)
    }
}
