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

class CharacterListViewController: UIViewControllerUtilities {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - VIP Properties
    
    var interactor: CharacterListInteractorProtocol!
    
    var router: CharacterListRouterProtocol!
    
    // MARK: - Private Properties
    
    private var characterList: [CharacterViewModel] = []
    
    // MARK: - Inits
    
    init() {
        super.init(nibName: "CharacterListViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Lifecycle
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        CharacterCell.registerOn(collectionView)
    }
    
    private func setupSearchBar() {
        setupSearchBar(
            placeholder: R.Localizable.search(),
            onSearch: { [weak self] searchText in
                self?.searchForCharacter(searchText)
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
        
        let section = interactor.section
        
        setupSegmentedControl(
            titles: titles, section: section.rawValue,
            action: #selector(didChangeControlSection))
    }
    
    @objc
    private func didChangeControlSection(_ control: BetterSegmentedControl) {
        guard let section = CharacterListSection(rawValue: control.index) else { return }
        navigationItem.title = section.title
        interactor.section = section
        fetchCharacterList()
        collectionView.setContentOffset(.zero, animated: true)
    }
}

// MARK: - CharacterListViewControllerProtocol Extension

extension CharacterListViewController: CharacterListViewControllerProtocol {
    
    func showCharacterList(_ viewModel: CharacterListViewModel) {
        var indexPaths: [IndexPath] = []
        let characters = viewModel.characters
        
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
    
    func reloadCharacters(_ viewModel: CharacterListViewModel, animated: Bool) {
        characterList = viewModel.characters
        
        if animated {
            collectionView.reloadData()
        }
    }
    
    func removeCharacter(at indexPath: IndexPath) {
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

// MARK: - UICollectionView Protocols Extensions

extension CharacterListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let lastRowIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        if lastRowIndex == indexPath.row {
            interactor.fetchCharacterNextPage()
        }
        
        cell.alpha = 0.0
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .allowUserInteraction, animations: {
            cell.alpha = 1.0
            cell.transform = .identity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.select(at: indexPath.item)
        router.proceedToCharacterDetails()
    }
}

extension CharacterListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CharacterCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? CharacterCell else { return UICollectionViewCell() }
        
        cell.setup(characterList[indexPath.item])
        cell.delegate = self
        
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

// MARK: - CharacterCellDelegate Extension

extension CharacterListViewController: CharacterCellDelegate {
    
    func setFavorite(_ cell: UICollectionViewCell, value: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        interactor.setFavorite(at: indexPath.item, value: value)
    }
}
