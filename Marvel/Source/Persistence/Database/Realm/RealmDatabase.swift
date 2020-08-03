//
//  RealmDatabase.swift
//  Marvel
//
//  Created by Ruan Reis on 31/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import RealmSwift

class RealmDatabase: PersistenceProtocol {
    
    func getCharacters() -> [Character] {
        do {
            let realm = try Realm()
            let resuls = realm.objects(CharacterRealm.self)
            
            return resuls.map({
                Character(
                    id: $0.id, name: $0.name,
                    description: $0.about,
                    isFavorite: $0.isFavorite,
                    thumbnail: Thumbnail(
                        path: $0.thumbnail?.path ?? "",
                        extension: $0.thumbnail?.extension ?? "")
                )})
            
        } catch {
            return []
        }
    }
    
    func save(_ character: Character) -> Bool {
        let object = CharacterRealm(character: character)
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .all)
            }
            return true
            
        } catch {
            return false
        }
    }
    
    func delete(_ character: Character) -> Bool {
        do {
            let realm = try Realm()
            
            guard let object = realm.object(ofType: CharacterRealm.self, forPrimaryKey: character.id)
                else { return false }
            
            try realm.write {
                realm.delete(object)
            }
            return true
            
        } catch {
            return false
        }
    }
}
