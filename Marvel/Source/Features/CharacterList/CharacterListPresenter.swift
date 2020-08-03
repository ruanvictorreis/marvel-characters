//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Alamofire

protocol CharacterListPresenterProtocol {
    
    func showCharacterList(_ response: CharacterListResponse?)
    
    func showCharacterList(_ results: [Character])
    
    func showCharacterListError(_ error: AFError?)
}

class CharacterListPresenter: CharacterListPresenterProtocol {
    
    // MARK: - VIP Properties
    
    weak var viewController: CharacterListViewControllerProtocol!
    
    // MARK: - Public Function
    
    func showCharacterList(_ response: CharacterListResponse?) {
        guard let results = response?.data.results
            else { showCharacterListError(); return }
        
        viewController.showCharacterList(results)
    }
    
    func showCharacterList(_ results: [Character]) {
        viewController.showCharacterList(results)
    }
    
    func showCharacterListError(_ error: AFError? = nil) {
        let errorMessage = error?.errorDescription ?? R.Localizable.errorDescription()
        viewController.showCharacterListError(errorMessage)
    }
}
