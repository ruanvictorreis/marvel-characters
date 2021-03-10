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
    
    private lazy var emptyListView: UIEmptyCharacterList = {
        let view = UIEmptyCharacterList(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Public Properties
    
    func scrollUp() {
        collectionView.setContentOffset(.zero, animated: true)
    }
    
    func reload() {
        collectionView.reloadData()
    }
    
    func setCollectionHidden(_ hidden: Bool) {
        collectionView.isHidden = hidden
        emptyListView.isHidden = !hidden
    }
    
    func indexPath(for cell: UICollectionViewCell) -> IndexPath? {
        collectionView.indexPath(for: cell)
    }
    
    func insertItems(at indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexPaths)
        })
    }
    
    func deleteItems(at indexPaths: [IndexPath]) {
        collectionView.deleteItems(at: indexPaths)
    }
    
    func registerCollection(_ target: UICollectionViewDelegate & UICollectionViewDataSource) {
        collectionView.delegate = target
        collectionView.dataSource = target
        CharacterCell.registerOn(collectionView)
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
        backgroundColor = .systemBackground
        emptyListView.isHidden = true
        collectionView.accessibilityIdentifier = "characterCollection"
    }
}
