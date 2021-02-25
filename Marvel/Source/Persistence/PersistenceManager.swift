//
//  PersistenceManager.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol PersistenceManagerProtocol {
    
    func getList<T: RealmObject>() -> Result<[T], MarvelError>
    
    func filter<T: RealmObject>(byName name: String) -> Result<[T], MarvelError>
    
    func save<T: RealmObject>(_ object: T) -> Result<T, MarvelError>
    
    func delete<T: RealmObject>(_ object: T) -> Result<T, MarvelError>
}

class PersistenceManager: PersistenceManagerProtocol {
    
    // MARK: - Private Properties
    
    private let database: RealmDatabaseProtocol
    
    // MARK: - Inits
    
    init() {
        database = RealmDatabase()
    }
    
    // MARK: - Public Functions
    
    func getList<T: RealmObject>() -> Result<[T], MarvelError> {
        do {
            let results: [T] = try database.getList()
            return .success(results)
            
        } catch {
            return .failure(.networkError)
        }
    }
    
    func filter<T: RealmObject>(byName name: String) -> Result<[T], MarvelError> {
        do {
            let results: [T] = try database.filter(byName: name)
            return .success(results)
            
        } catch {
            return .failure(.networkError)
        }
    }
    
    func save<T: RealmObject>(_ object: T) -> Result<T, MarvelError> {
        do {
            try database.save(object)
            return .success(object)
            
        } catch {
            return .failure(.databaseError)
        }
    }
    
    func delete<T: RealmObject>(_ object: T) -> Result<T, MarvelError> {
        do {
            guard let resource: T = try database.get(object.id) else {
                return .failure(.databaseError)
            }
            
            try database.delete(resource)
            return .success(object)
            
        } catch {
            return .failure(.databaseError)
        }
    }
}
