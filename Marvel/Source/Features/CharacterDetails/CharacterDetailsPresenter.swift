//
//  CharacterDetailsPresenter.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

protocol CharacterDetailsPresenterProtocol {
    
    func startComicsLoading()
    
    func stopComicsLoading()
    
    func showDetails(_ character: Character)
    
    func showDetails(_ character: Character, comics: [ComicBook])
    
    func showComicBookListError(_ error: AFError?)
}

class CharacterDetailsPresenter: CharacterDetailsPresenterProtocol {
    
    // MARK: - VIP Properties
    
    weak var viewController: CharacterDetailsViewControllerProtocol!
    
    // MARK: - Public Functions
    
    func startComicsLoading() {
        viewController.startComicsLoading()
    }
    
    func stopComicsLoading() {
        viewController.stopComicsLoading()
    }
    
    func showDetails(_ character: Character) {
        showDetails(character, comics: [])
    }
    
    func showDetails(_ character: Character, comics: [ComicBook]) {
        let viewModel = buildViewModel(character, comics: comics)
        viewController.showCharacterDetails(viewModel)
    }
    
    func showComicBookListError(_ error: AFError? = nil) {
        let errorMessage = error?.errorDescription ?? R.Localizable.errorDescription()
        viewController.showComicBookListError(errorMessage)
    }
    
    // MARK: - Private Functions
    
    private func buildViewModel(_ character: Character, comics: [ComicBook]) -> CharacterDetailsViewModel {
        let comicsViewModels = comics.map { comic in
            ComicViewModel(image: comic.imageURL)
        }
        
        return CharacterDetailsViewModel(
            name: character.name,
            description: character.description,
            image: character.imageURL,
            isLoved: character.isFavorite,
            comics: comicsViewModels)
    }
}
