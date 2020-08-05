//
//  CharacterListWorkerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

class CharacterListWorkerSuccessMock: CharacterListWorkerProtocol {
    
    var favoriteCharacters: [Character] = []
    
    func getFavoriteCharacters() -> [Character] {
        return favoriteCharacters
    }
    
    func saveFavorite(character: Character, sucess: Completation?, failure: Completation?) {
        favoriteCharacters.append(character)
        sucess?()
    }
    
    func deleteFavorite(character: Character, sucess: Completation?, failure: Completation?) {
        favoriteCharacters.removeAll(where: { $0.id == character.id })
        sucess?()
    }
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError) {
        
        let response = CharacterListResponseMock
            .build(offset: offset, pageCount: 20)
        
        sucess(response)
    }
    
    func fetchCharacterList(searchParameter: String, offset: Int,
                            sucess: @escaping CharacterListSuccess,
                            failure: @escaping CharacterListError) {
        
        var response = CharacterListResponseMock
            .build(offset: offset, pageCount: 20)
        
        let results = response.data.results
            .filter({ $0.name.contains(searchParameter) })
        
        response.data.results = results
        sucess(response)
    }
}
