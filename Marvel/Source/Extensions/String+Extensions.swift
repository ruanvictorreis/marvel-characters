//
//  String+Extensions.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    var percentEncoding: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
