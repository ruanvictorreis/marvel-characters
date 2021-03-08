//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 07/02/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterDetailsViewControllerProtocol: AnyObject {
    
    func startComicsLoading()
    
    func stopComicsLoading()
    
    func showCharacterDetails(_ viewModel: CharacterDetailsViewModel)
    
    func showCharacterDetailsError(_ errorMessage: String)
}

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let characterDetailsView = CharacterDetailsView()
    
    // MARK: - VIP Properties
    
    var interactor: CharacterDetailsInteractorProtocol!
    
    var router: CharacterDetailsRouterProtocol!
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        self.view = characterDetailsView
        characterDetailsView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchCharacterDetails()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupNavigation()
    }
    
    // MARK: - Private Functions
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - CharacterDetailsViewDelegate Extension

extension CharacterDetailsViewController: CharacterDetailsViewDelegate {
    
    func close() {
        navigationController?.popViewController(animated: true)
    }
    
    func loveIt(_ status: Bool) {
        interactor.setFavorite(status)
    }
}

// MARK: - CharacterDetailsViewControllerProtocol Extension

extension CharacterDetailsViewController: CharacterDetailsViewControllerProtocol {
    
    func startComicsLoading() {
        characterDetailsView.startComicsLoading()
    }
    
    func stopComicsLoading() {
        characterDetailsView.stopComicsLoading()
    }
    
    func showCharacterDetails(_ viewModel: CharacterDetailsViewModel) {
        characterDetailsView.setup(viewModel)
    }
    
    func showCharacterDetailsError(_ errorMessage: String) {
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}
