//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterListInteractorProtocol {
    
    func fetchCharacterList()
    
    func fetchCharacterNextPage()
}

class CharacterListInteractor: CharacterListInteractorProtocol {

    // MARK: - VIP properties
    
    var presenter: CharacterListPresenterProtocol!
    
    // MARK: - Private properties
    
    private let characterListWorker: CharacterListWorkerProtocol
    
    // MARK: - Inits
    
    init() {
        self.characterListWorker = CharacterListWorker()
    }
    
    // MARK: - Public functions
    
    func fetchCharacterList() {
        characterListWorker.fetchCharacterList(
            sucess: { [weak self] response in
                self?.presenter.showCharacterList(response)
            },
            failure: { [weak self] error in
                self?.presenter.showCharacterListError(error)
            })
    }
    
    func fetchCharacterNextPage() {
        characterListWorker.nextPage()
        fetchCharacterList()
    }
}
