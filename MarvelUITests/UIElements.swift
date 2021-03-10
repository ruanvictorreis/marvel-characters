//
//  UIElements.swift
//  MarvelUITests
//
//  Created by Ruan Reis on 04/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation
@testable import Marvel

struct UIElements {
    
    static let back = "backButtonId"
    
    static let heart = "heartButtonId"
    
    static let collection = "characterCollection"
    
    static let segmentedControl = "segmentedControl"
    
    static let search = R.Localizable.search()
    
    static let cancel = R.Localizable.cancel()
    
    static let noCharacters = R.Localizable.noResultFound()
    
    static let firstIndexPath = IndexPath(row: 0, section: 0)
    
}
