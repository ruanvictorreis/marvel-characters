//
//  CharacterCellDelegate.swift
//  Marvel
//
//  Created by Ruan Reis on 10/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterCellDelegate: AnyObject {
    
    func setFavorite(_ cell: UICollectionViewCell, value: Bool)
}
