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
    
    func fetchCharacterList(section: CharacterListViewSection)
    
    func fetchCharacterNextPage(section: CharacterListViewSection)
    
    func setFavorite(_ character: Character, section: CharacterListViewSection)
    
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
    
    init(characterListWorker: CharacterListWorkerProtocol) {
        self.characterListWorker = characterListWorker
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
        self.searchParameter = searchParameter.capitalized
        isSearchEnabled = true
        
        switch section {
        case .characters:
            searchForCharacter()
        case .favorites:
            searchForFavorites()
        }
    }
    
    func fetchCharacterNextPage(section: CharacterListViewSection) {
        guard section == .characters, shouldFetchNewPage() else { return }
        currentPage += 1
        
        isSearchEnabled
            ? searchForCharacter()
            : fetchCharacterList()
    }
    
    func setFavorite(_ character: Character, section: CharacterListViewSection) {
        character.isFavorite
            ? saveFavorite(character, section: section)
            : deleteFavorite(character, section: section)
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
    
    private func searchForFavorites() {
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
    
    private func saveFavorite(_ character: Character, section: CharacterListViewSection) {
        characterListWorker.saveFavorite(
            character: character,
            sucess: nil,
            failure: nil)
    }
    
    private func deleteFavorite(_ character: Character, section: CharacterListViewSection) {
        characterListWorker.deleteFavorite(
            character: character,
            sucess: { [weak self] in
                guard section == .favorites else { return }
                self?.presenter.removeCharacterFromList(character)
            },
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
