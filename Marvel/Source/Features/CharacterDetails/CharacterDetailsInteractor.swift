//
//  CharacterDetailsInteractor.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterDetailsInteractorProtocol {
    
    func fetchComicBookList(_ character: Int)
    
    func setFavorite(_ character: Character)
}

class CharacterDetailsInteractor: CharacterDetailsInteractorProtocol {

    // MARK: - VIP Properties
    
    var presenter: CharacterDetailsPresenterProtocol!
    
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
    
    func fetchComicBookList(_ character: Int) {
        comickBookListWorker.fetchComicBookList(
            character: character,
            sucess: { [weak self] response in
                self?.presenter.showComicBookList(response)
            },
            failure: { [weak self] error in
                self?.presenter.showComicBookListError(error)
            })
    }
    
    func setFavorite(_ character: Character) {
        character.isFavorite
            ? saveFavorite(character)
            : deleteFavorite(character)
    }
    
    // MARK: - Private Functions
    
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
