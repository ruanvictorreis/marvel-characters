//
//  ViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import BetterSegmentedControl

protocol CharacterListViewControllerProtocol: AnyObject {
    
    func showCharacterList(_ characters: [Character])
    
    func showCharacterListError(_ errorMessage: String)
    
    func removeCharacterFromList(_ character: Character)
}

class CharacterListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - VIP Properties
    
    var interactor: CharacterListInteractorProtocol!
    
    var router: CharacterListRouterProtocol!
    
    // MARK: - Private Properties
    
    private var characterList: [Character] = []
    
    private var section: CharacterListViewSection = .characters
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCharacterList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation(
            title: section.title,
            isTranslucent: true,
            hasLargeTitle: true)
        
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeNonFavoritesFromList()
    }
    
    // MARK: - Private Functions
    
    private func clean() {
        characterList = []
        interactor.restart()
        collectionView.reloadData()
    }
    
    private func fetchCharacterList() {
        clean()
        showLoading()
        interactor.fetchCharacterList(section: section)
    }
    
    private func searchForCharacter(_ searchParameter: String) {
        clean()
        showLoading()
        interactor.searchForCharacter(
            searchParameter: searchParameter, section: section)
    }
    
    private func fetchCharacterNextPage() {
        interactor.fetchCharacterNextPage(section: section)
    }
    
    private func setupUI() {
        setupSearchBar()
        setupSegmentedControl()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupSearchBar() {
        setupSearchBar(
            placeholder: R.Localizable.search(),
            onSearch: { [weak self] searchParameter in
                self?.searchForCharacter(searchParameter)
            },
            onCancel: { [weak self] in
                self?.fetchCharacterList()
            }
        )
    }
    
    private func setupSegmentedControl() {
        let titles: [String] = [
            R.Localizable.characters(),
            R.Localizable.favorites()]
        
        setupSegmentedControl(
            titles: titles,
            section: section.rawValue,
            action: #selector(didChangeControlSection))
    }
    
    @objc
    private func didChangeControlSection(_ control: BetterSegmentedControl) {
        guard let section = CharacterListViewSection(rawValue: control.index) else { return }
        self.section = section
        fetchCharacterList()
        navigationItem.title = section.title
        collectionView.setContentOffset(.zero, animated: true)
    }
    
    private func removeNonFavoritesFromList() {
        guard section == .favorites else { return }
        characterList
            .filter({ !$0.isFavorite })
            .forEach({
                removeCharacterFromList($0)
            })
    }
}

// MARK: - CharacterListViewController Protocol

extension CharacterListViewController: CharacterListViewControllerProtocol {
    
    func showCharacterList(_ characters: [Character]) {
        var indexPaths: [IndexPath] = []
        
        for index in characters.indices {
            let item = IndexPath(item: index + (characterList.count), section: 0)
            indexPaths.append(item)
        }
        
        characterList.append(contentsOf: characters)
        
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexPaths)
        })
        
        hideLoading()
        collectionView.isHidden = characterList.isEmpty
    }
    
    func removeCharacterFromList(_ character: Character) {
        guard let index = characterList.firstIndex(of: character)
            else { return }
        
        let indexPath = IndexPath(item: index, section: 0)
        characterList.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        collectionView.isHidden = characterList.isEmpty
    }
    
    func showCharacterListError(_ errorMessage: String) {
        hideLoading()
        collectionView.isHidden = characterList.isEmpty
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}

// MARK: - CharacterCellDelegate Protocol

extension CharacterListViewController: CharacterCellDelegate {
    
    func setFavorite(_ character: Character) {
        interactor.setFavorite(character, section: section)
    }
}

// MARK: - UICollectionViewDelegate Protocol

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
        router.proceedToCharacterDetails(characterList[indexPath.item])
    }
}

// MARK: - UICollectionViewDataSource Protocol

extension CharacterListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath)
            as? CharacterCollectionCell else { return UICollectionViewCell() }
        
        cell.setup(character: characterList[indexPath.item])
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Protocol

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
