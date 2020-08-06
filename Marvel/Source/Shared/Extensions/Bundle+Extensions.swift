//
//  Bundle+Extensions.swift
//  Marvel
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

extension Bundle {
    
    var keysPath: String? {
        Bundle.main.path(forResource: "Keys", ofType: "plist")
    }
    
    var keys: [String: String]? {
        guard let path = Bundle.main.keysPath else { return nil }
        return NSDictionary(contentsOfFile: path) as? [String: String]
    }
}
