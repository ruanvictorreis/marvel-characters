//
//  CharacterDetailsInteractor.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterDetailsDataStoreProtocol {
    
    var character: Character! { get set }
}

protocol CharacterDetailsInteractorProtocol {
    
    func fetchCharacterDetails()
    
    func setFavorite(_ value: Bool)
}

class CharacterDetailsInteractor: CharacterDetailsInteractorProtocol, CharacterDetailsDataStoreProtocol {
    
    // MARK: - VIP Properties
    
    var presenter: CharacterDetailsPresenterProtocol!
    
    // MARK: - Public Properties
    
    var character: Character!
    
    // MARK: - Private Properties
    
    private let characterListWorker: CharacterWorkerProtocol
    
    private let comickBookListWorker: ComicBookWorkerProtocol
    
    // MARK: - Inits
    
    init() {
        self.characterListWorker = CharacterWorker()
        self.comickBookListWorker = ComicBookWorker()
    }
    
    init(characterListWorker: CharacterWorkerProtocol, comickBookListWorker: ComicBookWorkerProtocol) {
        self.characterListWorker = characterListWorker
        self.comickBookListWorker = comickBookListWorker
    }
    
    // MARK: - Public Functions
    
    func fetchCharacterDetails() {
        presenter.showDetails(character)
        fetchComicBookList()
    }
    
    func setFavorite(_ value: Bool) {
        character.isFavorite = value
        
        character.isFavorite
            ? saveFavorite(character)
            : deleteFavorite(character)
    }
    
    // MARK: - Private Functions
    
    private func fetchComicBookList() {
        presenter.startComicsLoading()
        
        comickBookListWorker.fetchList(
            character: character.id,
            completation: { [weak self] result in
                switch result {
                case .success(let response):
                    self?.didFetchComicBookList(response)
                    self?.presenter.stopComicsLoading()
                case .failure(let error):
                    self?.presenter.showCharacterDetailsError(error)
                    self?.presenter.stopComicsLoading()
                }
            })
    }
    
    private func didFetchComicBookList(_ response: ComicBookListResponse?) {
        guard let comics = response?.data.results else { return }
        presenter.showDetails(character, comics: comics)
    }
    
    private func saveFavorite(_ character: Character) {
        let result = characterListWorker
            .saveFavorite(character)
        
        switch result {
        case .success:
            break
        case .failure(let error):
            presenter.showCharacterDetailsError(error)
        }
    }
    
    private func deleteFavorite(_ character: Character) {
        let result = characterListWorker
            .deleteFavorite(character)
        
        switch result {
        case .success:
            break
        case .failure(let error):
            presenter.showCharacterDetailsError(error)
        }
    }
}
