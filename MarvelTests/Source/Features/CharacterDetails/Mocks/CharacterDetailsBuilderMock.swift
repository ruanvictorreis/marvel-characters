//
//  CharacterDetailsBuilderMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

class CharacterDetailsBuilderMock {
    
    func build(characterListWorker: CharacterListWorkerProtocol,
               comickBookListWorker: ComicBookListWorkerProtocol) -> CharacterDetailsViewControllerMock {
        
        let viewController = CharacterDetailsViewControllerMock()
        let presenter = CharacterDetailsPresenter()
        
        let interactor = CharacterDetailsInteractor(
            characterListWorker: characterListWorker,
            comickBookListWorker: comickBookListWorker)
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
