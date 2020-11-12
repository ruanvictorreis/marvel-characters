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
    
    private let characterListWorker: CharacterListWorkerProtocol
    
    private let comickBookListWorker: ComicBookListWorkerProtocol
    
    // MARK: - Inits
    
    init() {
        self.characterListWorker = CharacterListWorker()
        self.comickBookListWorker = ComicBookListWorker()
    }
    
    init(characterListWorker: CharacterListWorkerProtocol, comickBookListWorker: ComicBookListWorkerProtocol) {
        self.characterListWorker = characterListWorker
        self.comickBookListWorker = comickBookListWorker
    }
    
    // MARK: - Public Functions
    
    func fetchCharacterDetails() {
        fetchComicBookList()
        presenter.showDetails(character)
    }
    
    func setFavorite(_ value: Bool) {
        character.isFavorite = value
        
        character.isFavorite
            ? saveFavorite(character)
            : deleteFavorite(character)
    }
    
    // MARK: - Private Functions
    
    private func fetchComicBookList() {
        comickBookListWorker.fetchComicBookList(
            character: character.id,
            sucess: { [weak self] response in
                self?.presenter.showComicBookList(response)
            },
            failure: { [weak self] error in
                self?.presenter.showComicBookListError(error)
            })
    }
    
    private func saveFavorite(_ character: Character) {
        characterListWorker.saveFavorite(
            character: character,
            sucess: nil,
            failure: nil)
    }
    
    private func deleteFavorite(_ character: Character) {
        characterListWorker.deleteFavorite(
            character: character,
            sucess: nil,
            failure: nil)
    }
}
