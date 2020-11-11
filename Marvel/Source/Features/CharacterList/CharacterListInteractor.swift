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
    
    func select(at index: Int)
    
    func setFavorite(at index: Int, value: Bool)
    
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
    
    private var characterList: [Character] = []
    
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
    
    func select(at index: Int) {
        selectedCharacter = characterList[index]
    }
    
    func setFavorite(at index: Int, value: Bool) {
        let character = characterList[index]
        character.isFavorite = value
        
        character.isFavorite
            ? saveFavorite(character)
            : deleteFavorite(character)
    }
    
    func reset() {
        currentPage = 0
        totalCount = 0
        characterList = []
        searchParameter = ""
        isSearchEnabled = false
    }
    
    // MARK: - Private Functions
    
    private func fetchCharacters() {
        characterListWorker.fetchCharacterList(
            offset: currentPage * pageCount,
            sucess: { [weak self] response in
                self?.didFetchCharacters(response)
            },
            failure: { [weak self] error in
                self?.presenter.showCharacterListError(error)
            })
    }
    
    private func searchForCharacter() {
        characterListWorker.fetchCharacterList(
            searchParameter: searchParameter,
            offset: currentPage * pageCount,
            sucess: { [weak self] response in
                self?.didFetchCharacters(response)
            },
            failure: { [weak self] error in
                self?.presenter.showCharacterListError(error)
            })
    }
    
    private func fetchFavorites() {
        let characters = characterListWorker
            .getFavoriteCharacters()
        
        presentCharacters(characters)
    }
    
    private func searchForFavorite() {
        let characters = characterListWorker
            .getFavoriteCharacters()
            .filter({ $0.name.contains(searchParameter) })
        
        presentCharacters(characters)
    }
    
    private func didFetchCharacters(_ response: CharacterListResponse?) {
        var characters = response?.data.results ?? []
        setFavorites(&characters)
        
        presentCharacters(characters)
        totalCount = response?.data.total ?? 0
    }
    
    private func presentCharacters(_ characters: [Character]) {
        presenter.showCharacterList(characters)
        characterList.append(contentsOf: characters)
    }
    
    private func shouldFetchNewPage() -> Bool {
        let isFirstFetch = totalCount == 0
        let shouldFetchMore = (currentPage + 1) * pageCount < totalCount
        return isFirstFetch || shouldFetchMore
    }
    
    private func setFavorites(_ results: inout [Character]) {
        let favorites = characterListWorker
            .getFavoriteCharacters()
            .map { character in character.id }
        
        results.forEach { character in
            let id = character.id
            character.isFavorite = favorites.contains(id)
        }
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
                self?.didDeleteFavorite(character)
            },
            failure: nil)
    }
    
    private func didDeleteFavorite(_ character: Character) {
        guard currentSection == .favorites else { return }
        characterList.removeAll { $0.id == character.id }
        presenter.removeCharacterFromList(character)
    }
}
