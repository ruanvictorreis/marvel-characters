//
//  PersistenceManager.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol PersistenceManagerProtocol {
    
    func getList<T: StorableObject>() -> Result<[T], MarvelError>
    
    func filter<T: StorableObject>(byName name: String) -> Result<[T], MarvelError>
    
    func save<T: StorableObject>(_ object: T) -> Result<T, MarvelError>
    
    func delete<T: StorableObject>(_ object: T) -> Result<T, MarvelError>
}

class PersistenceManager: PersistenceManagerProtocol {
    
    // MARK: - Private Properties
    
    private let datasource: RealmDatabaseProtocol
    
    // MARK: - Inits
    
    init() {
        datasource = RealmDatabase()
    }
    
    // MARK: - Public Functions
    
    func getList<T: StorableObject>() -> Result<[T], MarvelError> {
        do {
            let results: [T] = try datasource.getList()
            return .success(results)
            
        } catch {
            return .failure(.networkError)
        }
    }
    
    func filter<T: StorableObject>(byName name: String) -> Result<[T], MarvelError> {
        do {
            let results: [T] = try datasource.filter(byName: name)
            return .success(results)
            
        } catch {
            return .failure(.networkError)
        }
    }
    
    func save<T: StorableObject>(_ object: T) -> Result<T, MarvelError> {
        do {
            try datasource.save(object)
            return .success(object)
            
        } catch {
            return .failure(.databaseError)
        }
    }
    
    func delete<T: StorableObject>(_ object: T) -> Result<T, MarvelError> {
        do {
            guard let resource: T = try datasource.get(object.identifier) else {
                return .failure(.databaseError)
            }
            
            try datasource.delete(resource)
            return .success(object)
            
        } catch {
            return .failure(.databaseError)
        }
    }
}
