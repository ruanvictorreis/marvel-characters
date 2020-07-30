//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterListInteractorProtocol {
    
    func restart()
    
    func fetchCharacterList()
    
    func fetchCharacterNextPage()
    
    func searchForCharacter(_ searchParameter: String)
}

class CharacterListInteractor: CharacterListInteractorProtocol {

    // MARK: - VIP properties
    
    var presenter: CharacterListPresenterProtocol!
    
    // MARK: - Private properties
    
    private var searchingFor = ""
    
    private var isSearchEnabled = false
    
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
        guard characterListWorker.shouldFetchNewPage() else { return }
        characterListWorker.nextPage()
        
        isSearchEnabled
            ? searchForCharacter()
            : fetchCharacterList()
    }
    
    func searchForCharacter(_ searchParameter: String) {
        searchingFor = searchParameter
        isSearchEnabled = true
        
        characterListWorker.searchForCharacter(
            searchParameter: searchParameter,
            sucess: {[weak self] response in
                self?.presenter.showCharacterList(response)
            },
            failure: { [weak self] error in
                self?.presenter.showCharacterListError(error)
            })
    }
    
    func restart() {
        searchingFor = ""
        isSearchEnabled = false
        characterListWorker.restart()
    }
    
    // MARK: - Private functions
    
    private func searchForCharacter() {
        searchForCharacter(searchingFor)
    }
}
