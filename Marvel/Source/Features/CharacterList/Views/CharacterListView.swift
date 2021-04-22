//
//  CharacterListView.swift
//  Marvel
//
//  Created by Ruan Reis on 09/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit
import SnapKit

class CharacterListView: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var emptyListView: EmptyCharacterListView = {
        let view = EmptyCharacterListView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    // MARK: - Public Properties
    
    var characterList: [CharacterViewModel] = []
    
    // MARK: - Private Properties
    
    private unowned let delegate: (CharacterListViewDelegate & CharacterCellDelegate)
    
    // MARK: - Inits
    
    init(_ delegate: (CharacterListViewDelegate & CharacterCellDelegate)) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    
    func scrollUp() {
        collectionView.setContentOffset(.zero, animated: true)
    }
    
    func indexPath(for cell: UICollectionViewCell) -> IndexPath? {
        collectionView.indexPath(for: cell)
    }
    
    func reloadCharacters(_ characters: [CharacterViewModel], animated: Bool) {
        characterList = characters
        
        if animated {
            collectionView.reloadData()
        }
    }
    
    func insertCharacters(_ characters: [CharacterViewModel]) {
        var indexPaths: [IndexPath] = []
        
        for index in characters.indices {
            let item = IndexPath(item: index + (characterList.count), section: 0)
            indexPaths.append(item)
        }
        
        characterList.append(contentsOf: characters)
        
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexPaths)
        })
        
        setCollectionHidden(characterList.isEmpty)
    }
    
    func removeCharacter(at indexPath: IndexPath) {
        characterList.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        setCollectionHidden(characterList.isEmpty)
    }
    
    // MARK: - Private Functions
    
    private func fetchCharacterNextPage() {
        delegate.fetchCharacterNextPage()
    }
    
    private func selectCharacter(at index: Int) {
        delegate.selectCharacter(at: index)
    }
    
    private func setCollectionHidden(_ hidden: Bool) {
        emptyListView.isHidden = !hidden
        collectionView.isHidden = hidden
    }
}

// MARK: - UICollectionViewDelegate Extension

extension CharacterListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let lastRowIndex = collectionView.numberOfItems(
            inSection: indexPath.section) - 1
        
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
        selectCharacter(at: indexPath.item)
    }
}

// MARK: - UICollectionViewDataSource Extension

extension CharacterListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CharacterCell.identifier
        
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier, for: indexPath) as? CharacterCell
        else { return UICollectionViewCell() }
        
        cell.setup(characterList[indexPath.item])
        cell.delegate = delegate
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Extension

extension CharacterListView: UICollectionViewDelegateFlowLayout {
    
    private var margin: CGFloat { 16.0 }
    
    private var insetForSections: UIEdgeInsets {
        UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding = insetForSections.left + insetForSections.right + margin
        let width = (bounds.size.width - padding) / 2
        let ratio: CGFloat = 1.5
        let height = width * ratio
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - ViewCodeProtocol Extension

extension CharacterListView: ViewCodeProtocol {
    
    func setupSubviews() {
        addSubview(collectionView)
        addSubview(emptyListView)
    }
    
    func setupConstraints() {
        emptyListView.snp.makeConstraints { make in
            make.left.right.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setupComponents() {
        emptyListView.isHidden = true
        backgroundColor = .systemBackground
        CharacterCell.registerOn(collectionView)
        collectionView.accessibilityIdentifier = "characterCollection"
    }
}
