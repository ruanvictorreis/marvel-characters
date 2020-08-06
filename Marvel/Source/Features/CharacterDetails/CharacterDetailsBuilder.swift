//
//  CharacterDetailsBuilder.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class CharacterDetailsBuilder {
    
    // MARK: - Public Functions
    
    func build(_ character: Character) -> CharacterDetailsViewController? {
        let viewController = R.storyboard.main.characterDetails()
        let interactor = CharacterDetailsInteractor()
        let presenter = CharacterDetailsPresenter()
        let router = CharacterDetailsRouter()
        
        viewController?.interactor = interactor
        viewController?.router = router
        viewController?.character = character
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
