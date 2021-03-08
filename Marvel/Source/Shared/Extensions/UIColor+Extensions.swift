//
//  UIColor+Extensions.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - Init
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: 1.0)
    }
    
    // MARK: - Public Properties
    
    public class var water: UIColor {
        return UIColor(red: 8, green: 128, blue: 199)
    }
    
    public class var darkness: UIColor {
        return UIColor(red: 13, green: 25, blue: 33)
    }
    
    public class var darkGray: UIColor {
        return UIColor(red: 102, green: 102, blue: 102)
    }
    
    public class var lightFog: UIColor {
        return UIColor(red: 235, green: 235, blue: 235)
    }
    
    public class var cloud: UIColor {
        return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.5)
    }
    
    public class var eclipse: UIColor {
        return UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 0.8)
    }
    
    public class var lightGray: UIColor {
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
    }
}
