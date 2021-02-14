//
//  CharacterListBuilderMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

class CharacterListBuilderMock {
    
    func build(characterWorker: CharacterWorkerProtocol) -> CharacterListViewControllerMock {
        let viewController = CharacterListViewControllerMock()
        let presenter = CharacterListPresenter()
        
        let interactor = CharacterListInteractor(
            characterWorker: characterWorker)
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
