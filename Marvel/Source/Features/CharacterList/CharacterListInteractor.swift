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

    // MARK: - VIP Properties
    
    var presenter: CharacterListPresenterProtocol!
    
    // MARK: - Private Properties
    
    private var searchingFor = ""
    
    private var isSearchEnabled = false
    
    private let characterListWorker: CharacterListWorkerProtocol
    
    // MARK: - Inits
    
    init() {
        self.characterListWorker = CharacterListWorker()
    }
    
    // MARK: - Public Functions
    
    func fetchCharacterList() {
        characterListWorker.fetchCharacterList(
            sucess: { [weak self] response in
                let result = self?.setupFavorites(response)
                self?.presenter.showCharacterList(result)
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
        
        characterListWorker.fetchCharacterList(
            searchParameter: searchParameter,
            sucess: {[weak self] response in
                let result = self?.setupFavorites(response)
                self?.presenter.showCharacterList(result)
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
    
    // MARK: - Private Functions
    
    private func searchForCharacter() {
        searchForCharacter(searchingFor)
    }
    
    private func setupFavorites(_ response: CharacterListResponse?) -> CharacterListResponse? {
        let characters = characterListWorker
            .getFavoriteCharacters()
            .map({ $0.id })
        
        response?.data.results.forEach({
            $0.isFavorite = characters.contains($0.id)
        })
        
        return response
    }
}
