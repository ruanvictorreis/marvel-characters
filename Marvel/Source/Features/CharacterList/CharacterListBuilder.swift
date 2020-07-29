//
//  CharacterListBuilder.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

class CharacterListBuilder {
    
    // MARK: - Public functions
    
    func build() -> CharacterListViewController? {
        let viewController = R.storyboard.main.characterList()
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
        
        viewController?.interactor = interactor
        viewController?.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
