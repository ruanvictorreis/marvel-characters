//
//  CharacterListWorkerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation
@testable import Marvel

class CharacterListWorkerSuccessMock: CharacterWorkerProtocol {
    
    private var favoriteCharacters: [Character] = []
    
    func getFavoriteCharacters() -> Result<[Character], MarvelError> {
        return .success(favoriteCharacters)
    }
    
    func saveFavorite(_ character: Character) -> Result<Character, MarvelError> {
        favoriteCharacters.append(character)
        return .success(character)
    }
    
    func deleteFavorite(_ character: Character) -> Result<Character, MarvelError> {
        favoriteCharacters.removeAll(where: { $0.id == character.id })
        return .success(character)
    }
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError) {
        do {
            let data = FileReader.read(self, resource: "CharacterList")
            var response = try JSONDecoder().decode(
                CharacterListResponse.self, from: data ?? Data())
            
            let limit = offset + 20
            let total = response.data.results.count
            let endPage = limit < total ? limit : total
            let characters = response.data.results
            let results = Array(characters[offset..<endPage])
            
            response.data.offset = offset
            response.data.limit = limit
            response.data.total = total
            response.data.count = results.count
            response.data.results = results
            sucess(response)
        } catch {
            failure(.networkError)
        }
    }
    
    func fetchCharacterList(searchText: String, offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError) {
        do {
            let data = FileReader.read(self, resource: "CharacterSearch")
            var response = try JSONDecoder().decode(
                CharacterListResponse.self, from: data ?? Data())
            
            let limit = offset + 20
            let total = response.data.results.count
            let endPage = limit < total ? limit : total
            let characters = response.data.results
            let results = Array(characters[offset..<endPage])
            
            response.data.offset = offset
            response.data.limit = limit
            response.data.total = total
            response.data.count = results.count
            response.data.results = results
            sucess(response)
        } catch {
            failure(.networkError)
        }
    }
}

class CharacterListWorkerFailureMock: CharacterWorkerProtocol {
    
    func getFavoriteCharacters() -> Result<[Character], MarvelError> {
        return .failure(.databaseError)
    }
    
    func saveFavorite(_ character: Character) -> Result<Character, MarvelError> {
        return .failure(.databaseError)
    }
    
    func deleteFavorite(_ character: Character) -> Result<Character, MarvelError> {
        return .failure(.databaseError)
    }
    
    func fetchCharacterList(offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError) {
        failure(.networkError)
    }
    
    func fetchCharacterList(searchText: String, offset: Int,
                            sucess: @escaping CharacterWorkerSuccess,
                            failure: @escaping CharacterWorkerError) {
        failure(.networkError)
    }
}
