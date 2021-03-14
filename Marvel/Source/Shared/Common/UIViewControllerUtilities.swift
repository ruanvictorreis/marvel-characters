//
//  UIViewControllerUtilities.swift
//  Marvel
//
//  Created by Ruan Reis on 01/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import BetterSegmentedControl

typealias SearchCompletation = (_ searchParamter: String) -> Void

typealias CancelSearchCompletation = () -> Void

class UIViewControllerUtilities: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchOnCancel: CancelSearchCompletation?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Public Functions
    
    func setupSearchBar(placeholder: String, onSearch: @escaping SearchCompletation, onCancel: CancelSearchCompletation? = nil) {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchBar.tintColor = .label
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = placeholder
        
        search.searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({ $0.isNotEmpty})
            .subscribe(onNext: { searchText in
                onSearch(searchText)
            }).disposed(by: disposeBag)
        
        self.searchOnCancel = onCancel
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UISearchBarDelegate Extension

extension UIViewControllerUtilities: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchOnCancel?()
    }
}
