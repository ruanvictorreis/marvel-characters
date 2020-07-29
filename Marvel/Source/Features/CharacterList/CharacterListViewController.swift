//
//  ViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import Alamofire

protocol CharacterListViewControllerProtocol: AnyObject {
    
    func showCharacterList(characterList: [Character])
    
    func showCharacterListError(errorMessage: String)
}

class CharacterListViewController: UIViewController {
    
    // MARK: - VIP properties
    
    var interactor: CharacterListInteractorProtocol!
    
    var router: CharacterListRouterProtocol!
    
    // MARK: - IBOutlets
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private var characterList: [Character] = []
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCharacterList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setupSearchBar()
    }
    
    private func fetchCharacterList() {
        showLoading()
        interactor.fetchCharacterList()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupNavigation() {
        self.navigationItem.title = R.Localizable.characters()
    }
    
    private func setupSearchBar() {
        let search = UISearchController()
        search.searchBar.delegate = self
        search.searchBar.tintColor = .darkness
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = R.Localizable.search()
        
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension CharacterListViewController: CharacterListViewControllerProtocol {
    
    func showCharacterList(characterList: [Character]) {
        self.characterList = characterList
        
        hideLoading()
        collectionView.reloadData()
    }
    
    func showCharacterListError(errorMessage: String) {
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}

// MARK: - UICollectionView delegates and DataSource

extension CharacterListViewController: UICollectionViewDelegate {
    
}

extension CharacterListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.setup(character: characterList[indexPath.item])
        
        return cell
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    
    private var margin: CGFloat { 16.0 }
    
    private var insetForSections: UIEdgeInsets {
        UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = insetForSections.left + insetForSections.right + margin
        let width = (view.bounds.size.width - padding) / 2
        let ratio: CGFloat = 1.85
        let height = width * ratio
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - UISearchBar delegate

extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
