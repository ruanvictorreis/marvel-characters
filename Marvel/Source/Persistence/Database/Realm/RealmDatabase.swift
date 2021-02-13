//
//  RealmDatabase.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import RealmSwift

protocol RealmDatabaseProtocol {
    
    func get<T: RealmObject>(_ key: Any) -> T?
    
    func getAll<T: RealmObject>() -> [T]
    
    func save<T: RealmObject>(_ object: T) throws
    
    func delete<T: RealmObject>(_ object: T) throws
}

class RealmDatabase: RealmDatabaseProtocol {
    
    // MARK: Public Functions
    
    func get<T: RealmObject>(_ key: Any) -> T? {
        do {
            let realm = try Realm()
            return realm.object(ofType: T.self, forPrimaryKey: key)
        } catch {
            return nil
        }
    }
    
    func getAll<T: RealmObject>() -> [T] {
        do {
            let realm = try Realm()
            return Array(realm.objects(T.self))
        } catch {
            return []
        }
    }
    
    func save<T: RealmObject>(_ object: T) throws {
        let realm = try Realm()
        
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func delete<T: RealmObject>(_ object: T) throws {
        let realm = try Realm()
        
        try realm.write {
            realm.delete(object)
        }
    }
}
