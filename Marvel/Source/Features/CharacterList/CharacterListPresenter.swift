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
    
    func showCharacterListError(_ error: AFError?)
}

class CharacterListPresenter: CharacterListPresenterProtocol {

    // MARK: - VIP Properties
    
    weak var viewController: CharacterListViewControllerProtocol!
    
    // MARK: - Public Function
    
    func showCharacterList(_ response: CharacterListResponse?) {
        guard let results = response?.data.results else { return }
        viewController.showCharacterList(results)
    }
    
    func showCharacterListError(_ error: AFError?) {
        viewController.showCharacterListError(
            errorMessage: error?.errorDescription ?? R.Localizable.errorDescription())
    }
}
