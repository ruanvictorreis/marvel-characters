//
//  DelayedSearchControllerDelegate.swift
//  Marvel
//
//  Created by Ruan Reis on 15/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

protocol DelayedSearchControllerDelegate: AnyObject {
    
    func didFinishSearch(_ searchText: String)
    
    func didCancelSearch()
}
