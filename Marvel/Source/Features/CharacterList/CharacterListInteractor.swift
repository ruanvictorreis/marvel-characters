//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterListDataStoreProtocol {
    
    var selectedCharacter: Character? { get set }
}

protocol CharacterListInteractorProtocol: CharacterListDataStoreProtocol {
    
    var currentSection: CharacterListSection { get set }
    
    func reset()
    
    func fetchCharacterList()
    
    func fetchCharacterNextPage()
    
    func setFavorite(_ character: Character)
    
    func searchForCharacter(searchParameter: String)
}

class CharacterListInteractor: CharacterListInteractorProtocol {
    
    // MARK: - VIP Properties
    
    var presenter: CharacterListPresenterProtocol!
    
    // MARK: - Public Properties
    
    var selectedCharacter: Character?
    
    var currentSection: CharacterListSection = .characters
    
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
    
    func fetchCharacterList() {
        switch currentSection {
        case .favorites:
            fetchFavorites()
        case .characters:
            fetchCharacters()
        }
    }
    
    func searchForCharacter(searchParameter: String) {
        self.searchParameter = searchParameter.capitalized
        isSearchEnabled = true
        
        switch currentSection {
        case .favorites:
            searchForFavorite()
        case .characters:
            searchForCharacter()
        }
    }
    
    func fetchCharacterNextPage() {
        guard currentSection == .characters, shouldFetchNewPage() else { return }
        currentPage += 1
        
        isSearchEnabled
            ? searchForCharacter()
            : fetchCharacterList()
    }
    
    func setFavorite(_ character: Character) {
        character.isFavorite
            ? saveFavorite(character)
            : deleteFavorite(character)
    }
    
    func reset() {
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
    
    private func searchForFavorite() {
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
            sucess: { [weak self] in
                guard self?.currentSection == .favorites else { return }
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
