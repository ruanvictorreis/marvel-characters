//
//  CharacterDetailsBuilder.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

class CharacterDetailsBuilder {
    
    // MARK: - Public Functions
    
    static func build(_ character: Character) -> UIViewController? {
        let viewController = R.storyboard.main.characterDetails()
        let interactor = CharacterDetailsInteractor()
        let presenter = CharacterDetailsPresenter()
        let router = CharacterDetailsRouter()
        
        viewController?.interactor = interactor
        viewController?.router = router
        interactor.presenter = presenter
        interactor.character = character
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
