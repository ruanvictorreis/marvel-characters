//
//  StorableObject.swift
//  Marvel
//
//  Created by Ruan Reis on 12/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import RealmSwift

class StorableObject: Object {
    
    @objc dynamic var identifier = 0
    
    convenience init(_ id: Int) {
        self.init()
        self.identifier = id
    }
    
    override class func primaryKey() -> String {
        return "identifier"
    }
}
