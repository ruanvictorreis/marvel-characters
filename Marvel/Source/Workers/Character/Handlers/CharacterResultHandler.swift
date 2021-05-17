//
//  CharacterAdapterManager.swift
//  Marvel
//
//  Created by Ruan Reis on 17/05/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterResultHandlerProtocol {
    
    func makeResultForBusiness(_ result: Result<CharacterAdaptee, MarvelError>) -> Result<Character, MarvelError>
    
    func makeResultForBusiness(_ result: Result<[CharacterAdaptee], MarvelError>) -> Result<[Character], MarvelError>
}

class CharacterResultHandler: CharacterResultHandlerProtocol {
    
    // MARK: - Public Functions
    
    func makeResultForBusiness(_ result: Result<CharacterAdaptee, MarvelError>) -> Result<Character, MarvelError> {
        switch result {
        case .success(let object):
            let character = applyAdapter(object)
            return .success(character)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func makeResultForBusiness(_ result: Result<[CharacterAdaptee], MarvelError>) -> Result<[Character], MarvelError> {
        switch result {
        case .success(let objects):
            let characters = applyAdapter(objects)
            return .success(characters)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    // MARK: - Private Functions
    
    private func applyAdapter(_ objects: [CharacterAdaptee]) -> [Character] {
        return objects.map { object in
            applyAdapter(object)
        }
    }
    
    private func applyAdapter(_ object: CharacterAdaptee) -> Character {
        return CharacterAdapter(object)
    }
}
