//
//  BaseViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 01/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import BetterSegmentedControl

typealias SearchAction = (_ searchParamter: String) -> Void

class BaseViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let disposeBag = DisposeBag()
    
    private var searchOnCancel: Completation?

    // MARK: - Public Functions
    
    func setupNavigation(title: String = "",
                         isHidden: Bool = false,
                         isTranslucent: Bool = true,
                         hasLargeTitle: Bool = false) {
        
        navigationItem.title = title
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = isTranslucent
        navigationController?.navigationBar.prefersLargeTitles = hasLargeTitle
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.setNavigationBarHidden(isHidden, animated: true)
    }
    
    func setupSegmentedControl(titles: [String]) {
        let normalFont: UIFont = .systemFont(ofSize: 14.0, weight: .medium)
        let selectedFont: UIFont = .systemFont(ofSize: 14.0, weight: .bold)
        
        let segments = LabelSegment.segments(
            withTitles: titles,
            normalFont: normalFont,
            normalTextColor: .darkGray,
            selectedFont: selectedFont,
            selectedTextColor: .white)
        
        let options: [BetterSegmentedControlOption] = [
            .backgroundColor(.clear),
            .indicatorViewBackgroundColor(.darkness),
            .cornerRadius(CGFloat(20.0))]
        
        let segmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 40.0),
            segments: segments,
            index: 0,
            options: options)
        
        self.navigationItem.titleView = segmentedControl
    }
    
    func setupSearchBar(placeholder: String,
                        onSearch: @escaping SearchAction,
                        onCancel: Completation? = nil) {
        
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchBar.tintColor = .darkness
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = placeholder
        
        search.searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({ $0.isNotEmpty})
            .subscribe(onNext: { searchParameter in
                onSearch(searchParameter)
            }).disposed(by: disposeBag)
        
        self.searchOnCancel = onCancel
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

// MARK: - UISearchBarDelegate Protocol

extension BaseViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchOnCancel?()
    }
}
