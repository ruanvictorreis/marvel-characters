//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterListRouterProtocol {
    
    func proceedToCharacterDetails()
}

protocol CharacterListDataPassingProtocol {
    
    var dataStore: CharacterListDataStoreProtocol! { get }
}

class CharacterListRouter: CharacterListRouterProtocol, CharacterListDataPassingProtocol {
    
    // MARK: - VIP Properties
    
    weak var viewController: CharacterListViewController!
    
    // MARK: - Public Properties
    
    var dataStore: CharacterListDataStoreProtocol!
    
    // MARK: - Public Functions
    
    func proceedToCharacterDetails() {
        guard let character = dataStore.character else { return }
        
        guard let detailsScene = CharacterDetailsBuilder
                .build(character) else { return }
        
        viewController.navigationController?
            .pushViewController(detailsScene, animated: true)
    }
}
