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
    
    func saveFavorite(character: Character)
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
    
    func saveFavorite(character: Character) {
        characterListWorker.saveFavorite(
            character: character,
            sucess: nil,
            failure: {
                //self?.presenter.showComicBookListError(error)
            })
    }
}
