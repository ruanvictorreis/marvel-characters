//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 08/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit
import BetterSegmentedControl

protocol CharacterListViewControllerProtocol: AnyObject {
    
    func showCharacterList(_ viewModel: CharacterListViewModel)
    
    func removeCharacter(at indexPath: IndexPath)
    
    func showCharacterListError(_ errorMessage: String)
    
    func reloadCharacters(_ viewModel: CharacterListViewModel, animated: Bool)
}

class CharacterListViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: CharacterListInteractorProtocol!
    
    var router: CharacterListRouterProtocol!
    
    // MARK: - Private Properties
    
    private lazy var characterListView: CharacterListView = {
        return CharacterListView(self)
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        self.view = characterListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCharacterList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        interactor.reloadCharacters(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.checkChangesInFavorites()
    }
    
    // MARK: - Private Functions
    
    private func setupNavigation() {
        navigationItem.title = interactor.section.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func fetchCharacterList() {
        showLoading()
        interactor.reset()
        interactor.fetchCharacterList()
    }
    
    private func searchForCharacter(_ characterName: String) {
        showLoading()
        interactor.reset()
        interactor.searchForCharacter(characterName)
    }
    
    private func setupUI() {
        setupSearchBar()
        setupSegmentedControl()
    }
    
    private func setupSearchBar() {
        let delayedSearch = DelayedSearchController()
        delayedSearch.delayedSearchDelegate = self
        
        navigationItem.searchController = delayedSearch
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSegmentedControl() {
        let titles: [String] = [
            R.Localizable.characters(),
            R.Localizable.favorites()]
        
        let action = #selector(didChangeControlSection)
        
        let segmentedControl = SegmentedControlBuilder()
            .set(titles: titles)
            .set(width: 300, height: 40)
            .set(self, action: action)
            .build()
        
        self.navigationItem.titleView = segmentedControl
    }
    
    @objc
    private func didChangeControlSection(_ control: BetterSegmentedControl) {
        guard let section = CharacterListSection(rawValue: control.index) else { return }
        navigationItem.title = section.title
        interactor.section = section
        fetchCharacterList()
        characterListView.scrollUp()
    }
}

// MARK: - CharacterListViewControllerProtocol Extension

extension CharacterListViewController: CharacterListViewControllerProtocol {
    
    func showCharacterList(_ viewModel: CharacterListViewModel) {
        characterListView.insertCharacters(viewModel.characters)
        hideLoading()
    }
    
    func reloadCharacters(_ viewModel: CharacterListViewModel, animated: Bool) {
        characterListView.reloadCharacters(
            viewModel.characters, animated: animated)
    }
    
    func removeCharacter(at indexPath: IndexPath) {
        characterListView.removeCharacter(at: indexPath)
    }
    
    func showCharacterListError(_ errorMessage: String) {
        hideLoading()
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}

// MARK: - CharacterListViewDelegate Extension

extension CharacterListViewController: CharacterListViewDelegate {
    
    func fetchCharacterNextPage() {
        interactor.fetchCharacterNextPage()
    }
    
    func selectCharacter(at index: Int) {
        interactor.select(at: index)
        router.proceedToCharacterDetails()
    }
    
    func setFavorite(at index: Int, value: Bool) {
        interactor.setFavorite(at: index, value: value)
    }
}

// MARK: - DelayedSearchControllerDelegate Extension

extension CharacterListViewController: DelayedSearchControllerDelegate {
    
    func didFinishSearch(_ searchText: String) {
        searchForCharacter(searchText)
    }
    
    func didCancelSearch() {
        fetchCharacterList()
    }
}
