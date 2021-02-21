//
//  RealmObject.swift
//  Marvel
//
//  Created by Ruan Reis on 12/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import RealmSwift

class RealmObject: Object {
    
    @objc dynamic var id = 0
    
    convenience init(_ id: Int) {
        self.init()
        self.id = id
    }
    
    override class func primaryKey() -> String {
        return "id"
    }
}
