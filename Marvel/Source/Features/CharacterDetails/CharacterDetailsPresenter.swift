//
//  CharacterDetailsPresenter.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

protocol CharacterDetailsPresenterProtocol {
    
    func showDetails(_ character: Character)
    
    func showComicBookList(_ response: ComicBookListResponse?)
    
    func showComicBookListError(_ error: AFError?)
}

class CharacterDetailsPresenter: CharacterDetailsPresenterProtocol {
    
    // MARK: - VIP Properties
    
    weak var viewController: CharacterDetailsViewControllerProtocol!
    
    // MARK: - Public Functions
    
    func showDetails(_ character: Character) {
        let viewModel = CharacterDetailsViewModel(
            name: character.name, description: character.description,
            image: character.imageURL, isLoved: character.isFavorite)
        
        viewController.showCharacterDetails(viewModel)
    }
    
    func showComicBookList(_ response: ComicBookListResponse?) {
        guard let results = response?.data.results
        else { showComicBookListError(); return }
        
        viewController.showCommicBookList(results)
    }
    
    func showComicBookListError(_ error: AFError? = nil) {
        let errorMessage = error?.errorDescription ?? R.Localizable.errorDescription()
        viewController.showComicBookListError(errorMessage)
    }
}
