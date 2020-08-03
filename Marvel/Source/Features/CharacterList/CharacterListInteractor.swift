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
    
    func setupFavorite(character: Character, isFavorite: Bool)
    
    func fetchCharacterList(section: CharacterListViewSection)
    
    func fetchCharacterNextPage(section: CharacterListViewSection)
    
    func searchForCharacter(searchParameter: String, section: CharacterListViewSection)
}

class CharacterListInteractor: CharacterListInteractorProtocol {
    
    // MARK: - VIP Properties
    
    var presenter: CharacterListPresenterProtocol!
    
    // MARK: - Private Properties
    
    private let pageCount = 20
    
    private var totalCount = 0
    
    private var currentPage = 0

    private var searchParameter = ""
    
    private var isSearchEnabled = false
    
    private let characterListWorker: CharacterListWorkerProtocol
    
    // MARK: - Inits
    
    init() {
        self.characterListWorker = CharacterListWorker()
    }
    
    // MARK: - Public Functions
    
    func fetchCharacterList(section: CharacterListViewSection = .characters) {
        switch section {
        case .characters:
            fetchCharacters()
        case .favorites:
            fetchFavorites()
        }
    }
    
    func searchForCharacter(searchParameter: String, section: CharacterListViewSection) {
        self.searchParameter = searchParameter
        isSearchEnabled = true
        
        switch section {
        case .characters:
            searchForCharacter()
        case .favorites:
            searchInFavorites()
        }
    }
    
    func fetchCharacterNextPage(section: CharacterListViewSection) {
        guard section == .characters, shouldFetchNewPage() else { return }
        currentPage += 1
        
        isSearchEnabled
            ? searchForCharacter()
            : fetchCharacterList()
    }
    
    func setupFavorite(character: Character, isFavorite: Bool) {
        character.isFavorite = isFavorite
        
        isFavorite
            ? saveFavorite(character)
            : deleteFavorite(character)
    }
    
    func restart() {
        currentPage = 0
        totalCount = 0
        searchParameter = ""
        isSearchEnabled = false
    }
    
    // MARK: - Private Functions
    
    private func fetchCharacters() {
        characterListWorker.fetchCharacterList(
            offset: currentPage * pageCount,
            sucess: { [weak self] results in
                let response = self?.setFavorites(results)
                self?.presenter.showCharacterList(response)
                self?.totalCount = response?.data.total ?? 0
            },
            failure: { [weak self] error in
                self?.presenter.showCharacterListError(error)
        })
    }
    
    private func searchForCharacter() {
        characterListWorker.fetchCharacterList(
            searchParameter: searchParameter,
            offset: currentPage * pageCount,
            sucess: {[weak self] results in
                let response = self?.setFavorites(results)
                self?.presenter.showCharacterList(response)
                self?.totalCount = response?.data.total ?? 0
            },
            failure: { [weak self] error in
                self?.presenter.showCharacterListError(error)
        })
    }
    
    private func fetchFavorites() {
        let characters = characterListWorker.getFavoriteCharacters()
        presenter.showCharacterList(characters)
    }
    
    private func searchInFavorites() {
        let characters = characterListWorker
            .getFavoriteCharacters()
            .filter({ $0.name.contains(searchParameter) })
        
        presenter.showCharacterList(characters)
    }
    
    private func shouldFetchNewPage() -> Bool {
        let isFirstFetch = totalCount == 0
        let shouldFetchMore = (currentPage + 1) * pageCount < totalCount
        return isFirstFetch || shouldFetchMore
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
    
    private func setFavorites(_ response: CharacterListResponse?) -> CharacterListResponse? {
        let characters = characterListWorker
            .getFavoriteCharacters()
            .map({ $0.id })
        
        response?.data.results.forEach({
            $0.isFavorite = characters.contains($0.id)
        })
        
        return response
    }
}
