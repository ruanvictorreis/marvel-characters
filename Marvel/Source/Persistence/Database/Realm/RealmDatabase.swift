//
//  RealmDatabase.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import RealmSwift

class RealmDatabase: PersistenceProtocol {
    
    func save(_ character: Character) -> Bool {
        let object = CharacterRealm(character: character)
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
            return true
        
        } catch {
            return false
        }
    }
}
