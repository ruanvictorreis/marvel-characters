//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterListDataStoreProtocol {
    
    var character: Character? { get set }
}

protocol CharacterListInteractorProtocol: CharacterListDataStoreProtocol {
    
    var section: CharacterListSection { get set }
    
    func reset()
    
    func fetchCharacterList()
    
    func fetchCharacterNextPage()
    
    func reloadCharacters(animated: Bool)
    
    func checkChangesInFavorites()
    
    func select(at index: Int)
    
    func setFavorite(at index: Int, value: Bool)
    
    func searchForCharacter(_ characterName: String)
}

class CharacterListInteractor: CharacterListInteractorProtocol {
    
    // MARK: - VIP Properties
    
    var presenter: CharacterListPresenterProtocol!
    
    // MARK: - Public Properties
    
    var character: Character?
    
    var section: CharacterListSection = .characters
    
    // MARK: - Private Properties
    
    private let pageCount = 20
    
    private var totalCount = 0
    
    private var currentPage = 0
    
    private var searchText = ""
    
    private var isSearchEnabled = false
    
    private var characterList: [Character] = []
    
    private let characterWorker: CharacterWorkerProtocol
    
    // MARK: - Inits
    
    init() {
        self.characterWorker = CharacterWorker()
    }
    
    init(characterWorker: CharacterWorkerProtocol) {
        self.characterWorker = characterWorker
    }
    
    // MARK: - Public Functions
    
    func fetchCharacterList() {
        switch section {
        case .favorites:
            fetchFavorites()
        case .characters:
            fetchCharacters()
        }
    }
    
    func searchForCharacter(_ characterName: String) {
        isSearchEnabled = true
        searchText = characterName.capitalized
        
        switch section {
        case .favorites:
            searchForFavorite()
        case .characters:
            searchForCharacter()
        }
    }
    
    func fetchCharacterNextPage() {
        guard section == .characters, shouldFetchNewPage() else { return }
        currentPage += 1
        
        isSearchEnabled
            ? searchForCharacter()
            : fetchCharacterList()
    }
    
    func select(at index: Int) {
        character = characterList[index]
    }
    
    func setFavorite(at index: Int, value: Bool) {
        let character = characterList[index]
        character.isFavorite = value
        
        character.isFavorite
            ? saveFavorite(character)
            : deleteFavorite(character)
    }
    
    func checkChangesInFavorites() {
        guard section == .favorites else { return }
        
        let nonFavorites = characterList
            .filter { !$0.isFavorite }
        
        nonFavorites.forEach { character in
            removeFromFavorites(character)
        }
    }
    
    func reset() {
        currentPage = 0
        totalCount = 0
        characterList = []
        searchText = ""
        isSearchEnabled = false
        reloadCharacters(animated: true)
    }
    
    func reloadCharacters(animated: Bool) {
        presenter.reloadCharacters(characterList, animated: animated)
    }
    
    // MARK: - Private Functions
    
    private func fetchCharacters() {
        characterWorker.fetchCharacterList(
            offset: currentPage * pageCount,
            completation: { [weak self] result in
                switch result {
                case .success(let response):
                    self?.didFetchCharacters(response)
                case .failure(let error):
                    self?.presenter.showCharacterListError(error)
                }
            })
    }
    
    private func searchForCharacter() {
        characterWorker.fetchCharacterList(
            searchText: searchText,
            offset: currentPage * pageCount,
            completation: { [weak self] result in
                switch result {
                case .success(let response):
                    self?.didFetchCharacters(response)
                case .failure(let error):
                    self?.presenter.showCharacterListError(error)
                }
            })
    }
    
    private func fetchFavorites() {
        let result = characterWorker.getFavorites()
        
        switch result {
        case .success(let characters):
            presentCharacters(characters)
        case .failure(let error):
            presenter.showCharacterListError(error)
        }
    }
    
    private func searchForFavorite() {
        let result = characterWorker.filterFavorites(byName: searchText)
        
        switch result {
        case .success(let characters):
            presentCharacters(characters)
        case .failure(let error):
            presenter.showCharacterListError(error)
        }
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
        let favorites: [Character]
        let result = characterWorker.getFavorites()
        
        switch result {
        case .success(let characters):
            favorites = characters
        case .failure:
            favorites = []
        }
        
        let dictionary = Dictionary(
            uniqueKeysWithValues: favorites.map { character in
                (character.id, character)
            })
        
        results.forEach { character in
            let id = character.id
            character.isFavorite = dictionary[id] != nil
        }
    }
    
    private func saveFavorite(_ character: Character) {
        let result = characterWorker
            .saveFavorite(character)
        
        switch result {
        case .success:
            reloadCharacters(animated: false)
        case .failure(let error):
            presenter.showCharacterListError(error)
        }
    }
    
    private func deleteFavorite(_ character: Character) {
        let result = characterWorker
            .deleteFavorite(character)
        
        switch result {
        case .success(let character):
            removeFromFavorites(character)
        case .failure(let error):
            presenter.showCharacterListError(error)
        }
    }
    
    private func removeFromFavorites(_ character: Character) {
        guard section == .favorites else { return }
        
        if let index = characterList.firstIndex(of: character) {
            characterList.remove(at: index)
            presenter.removeCharacterFromList(at: index)
        }
    }
}
