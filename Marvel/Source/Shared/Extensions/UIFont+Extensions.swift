//
//  UIFont+Extensions.swift
//  Marvel
//
//  Created by Ruan Reis on 06/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func semiBoldSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return .systemFont(ofSize: fontSize, weight: .semibold)
    }
}
