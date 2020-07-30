//
//  ViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift

protocol CharacterListViewControllerProtocol: AnyObject {
    
    func showCharacterList(_ characters: [Character])
    
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
    
    private let disposeBag = DisposeBag()
    
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
    
    // MARK: - Private functions
    
    private func clean() {
        characterList = []
        interactor.restart()
        collectionView.reloadData()
    }
    
    private func fetchCharacterList() {
        clean()
        showLoading()
        interactor.fetchCharacterList()
    }
    
    private func searchForCharacter(_ searchParameter: String) {
        clean()
        showLoading()
        interactor.searchForCharacter(searchParameter)
    }
    
    private func fetchCharacterNextPage() {
        interactor.fetchCharacterNextPage()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupNavigation() {
        self.navigationItem.title = R.Localizable.characters()
    }
    
    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchBar.tintColor = .darkness
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = R.Localizable.search()
        
        search.searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({ $0.isNotEmpty})
            .subscribe(onNext: { [weak self] searchParameter in
                self?.searchForCharacter(searchParameter)
            }).disposed(by: disposeBag)
        
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
}

// MARK: - CharacterListViewController protocol requirements

extension CharacterListViewController: CharacterListViewControllerProtocol {
        
    func showCharacterList(_ characters: [Character]) {
        var indexPaths: [IndexPath] = []
        
        for index in characters.indices {
            let item = IndexPath(item: index + (characterList.count), section: 0)
            indexPaths.append(item)
        }
        
        characterList.append(contentsOf: characters)
        
        self.collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: indexPaths)
        })
        
        hideLoading()
    }
    
    func showCharacterListError(errorMessage: String) {
        hideLoading()
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}

// MARK: - UICollectionView protocols requirements

extension CharacterListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let lastRowIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        if lastRowIndex == indexPath.row {
            fetchCharacterNextPage()
        }
        
        cell.alpha = 0.0
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .allowUserInteraction, animations: {
            cell.alpha = 1.0
            cell.transform = .identity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //router.proceedToCharacterDetails(character: characterList[indexPath.item])
    }
}

extension CharacterListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath)
            as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setup(character: characterList[indexPath.item])
        
        return cell
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    
    private var margin: CGFloat { 16.0 }
    
    private var insetForSections: UIEdgeInsets {
        UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = insetForSections.left + insetForSections.right + margin
        let width = (view.bounds.size.width - padding) / 2
        let ratio: CGFloat = 1.5
        let height = width * ratio
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - UISearchBarDelegate protocol requirements

extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchCharacterList()
    }
}
