//
//  RealmDatabase.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import RealmSwift

protocol RealmDatabaseProtocol {
    
    func get<T: StorableObject>(_ key: Any) throws -> T?
    
    func getList<T: StorableObject>() throws -> [T]
    
    func filter<T: StorableObject>(byName name: String) throws -> [T]
    
    func save<T: StorableObject>(_ object: T) throws
    
    func delete<T: StorableObject>(_ object: T) throws
}

class RealmDatabase: RealmDatabaseProtocol {
    
    // MARK: Public Functions
    
    func get<T: StorableObject>(_ key: Any) throws -> T? {
        let realm = try Realm()
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    func getList<T: StorableObject>() throws -> [T] {
        let realm = try Realm()
        return Array(realm.objects(T.self))
    }
    
    func filter<T: StorableObject>(byName name: String) throws -> [T] {
        let realm = try Realm()
        let predicate = NSPredicate(format: "name contains[cd] %@", name)
        let results = realm.objects(T.self).filter(predicate)
        return Array(results)
    }
    
    func save<T: StorableObject>(_ object: T) throws {
        let realm = try Realm()
        
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func delete<T: StorableObject>(_ object: T) throws {
        let realm = try Realm()
        
        try realm.write {
            realm.delete(object)
        }
    }
}
