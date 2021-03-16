//
//  SearchWithDebounceControllerDelegate.swift
//  Marvel
//
//  Created by Ruan Reis on 15/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

protocol SearchWithDebounceControllerDelegate: AnyObject {
    
    func onSearch(_ searchText: String)
    
    func onCancel()
}
