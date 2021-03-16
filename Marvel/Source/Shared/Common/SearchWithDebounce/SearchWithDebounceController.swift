//
//  SearchWithDebounceController.swift
//  Marvel
//
//  Created by Ruan Reis on 15/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

class SearchWithDebounceController: UISearchController {
    
    // MARK: - Private Properties
    
    private var searchTask: DispatchWorkItem?
    
    // MARK: - Public Properties
    
    weak var searchDelegate: SearchWithDebounceControllerDelegate?
    
    // MARK: - Inits
    
    init() {
        super.init(searchResultsController: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Public Properties
    
    func setupUI() {
        searchBar.delegate = self
        searchBar.tintColor = .label
        searchBar.placeholder = R.Localizable.search()
        obscuresBackgroundDuringPresentation = false
    }
}

extension SearchWithDebounceController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isNotEmpty else { return }
        
        searchTask?.cancel()
        
        let newSearchTask = DispatchWorkItem { [weak self] in
            DispatchQueue.main.async {
                self?.searchDelegate?.onSearch(searchText)
            }
        }
        
        self.searchTask = newSearchTask
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: newSearchTask)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchDelegate?.onCancel()
    }
}
