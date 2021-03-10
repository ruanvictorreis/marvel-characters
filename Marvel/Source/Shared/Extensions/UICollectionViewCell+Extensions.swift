//
//  UICollectionViewCell+Extensions.swift
//  Marvel
//
//  Created by Ruan Reis on 07/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static func registerOn(_ collectionView: UICollectionView) {
        let reuseIdentifier = String(describing: self.self)
        collectionView.register(self.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
