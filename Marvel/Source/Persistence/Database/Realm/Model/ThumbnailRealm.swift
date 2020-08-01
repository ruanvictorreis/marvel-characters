//
//  ThumbnailRealm.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import RealmSwift

class ThumbnailRealm: Object {
    
    @objc dynamic var path: String = ""
    
    @objc dynamic var `extension`: String = ""
    
    convenience init(thumbnail: Thumbnail) {
        self.init()
        self.path = thumbnail.path
        self.extension = thumbnail.extension
    }
}
