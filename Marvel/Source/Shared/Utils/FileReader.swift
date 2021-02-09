//
//  FileReader.swift
//  Marvel
//
//  Created by Ruan Reis on 08/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

struct FileReader {
    
    static func read(_ target: AnyObject, resource: String) -> Data? {
        let bundle = Bundle(for: type(of: target))
        let filePath = bundle.path(forResource: resource, ofType: "json")
        return try? String(contentsOfFile: filePath ?? "").data(using: .utf8)
    }
}
