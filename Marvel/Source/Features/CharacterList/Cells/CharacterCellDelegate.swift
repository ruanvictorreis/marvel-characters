//
//  CharacterCellDelegate.swift
//  Marvel
//
//  Created by Ruan Reis on 10/11/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterCellDelegate: AnyObject {
    
    func setFavorite(_ cell: UICollectionViewCell, value: Bool)
}
