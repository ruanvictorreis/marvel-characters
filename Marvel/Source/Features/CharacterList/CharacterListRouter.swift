//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterListRouterProtocol {
    
    func proceedToCharacterDetails(_ character: Character)
}

class CharacterListRouter: CharacterListRouterProtocol {
    
    // MARK: - VIP Properties
    
    weak var viewController: CharacterListViewController!
    
    // MARK: - Public Functions
    
    func proceedToCharacterDetails(_ character: Character) {
        guard let nextScene = CharacterDetailsBuilder().build(character) else { return }
        viewController.navigationController?.pushViewController(nextScene, animated: true)
    }
}
