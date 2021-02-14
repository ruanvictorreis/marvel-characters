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
    
    func setupSegmentedControl(titles: [String], section: Int, action: Selector) {
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
            index: section,
            options: options)
        
        segmentedControl.accessibilityIdentifier = "segmentedControl"
        segmentedControl.addTarget(self, action: action, for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
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
