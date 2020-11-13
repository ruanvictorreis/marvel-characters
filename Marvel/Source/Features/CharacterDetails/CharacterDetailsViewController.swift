//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterDetailsViewControllerProtocol: AnyObject {
    
    func startComicsLoading()
    
    func stopComicsLoading()
    
    func showCharacterDetails(_ viewModel: CharacterDetailsViewModel)
    
    func showComicBookListError(_ errorMessage: String)
}

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var characterName: UILabel!
    
    @IBOutlet private var characterDescription: UILabel!
    
    @IBOutlet private var characterThumbnail: UIImageView!
    
    @IBOutlet private var loveItButton: UIHeartButton!
    
    @IBOutlet private var comicsCarousel: ComicBookCarouselView!
    
    // MARK: - VIP Properties
    
    var interactor: CharacterDetailsInteractorProtocol!
    
    var router: CharacterDetailsRouterProtocol!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchCharacterDetails()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupNavigation(isHidden: true)
    }
    
    // MARK: - Private Functions
    
    @IBAction private func loveIt(_ sender: UIHeartButton) {
        loveItButton.toggleIt()
        interactor.setFavorite(loveItButton.isFilled)
    }
    
    @IBAction private func close(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    } 
}

// MARK: - CharacterDetailsViewControllerProtocol Extension

extension CharacterDetailsViewController: CharacterDetailsViewControllerProtocol {
    
    func startComicsLoading() {
        comicsCarousel.startLoading()
    }
    
    func stopComicsLoading() {
        comicsCarousel.stopLoading()
    }
    
    func showCharacterDetails(_ viewModel: CharacterDetailsViewModel) {
        characterName.text = viewModel.name
        characterDescription.text = viewModel.description
        characterThumbnail.load(url: viewModel.image)
        comicsCarousel.setup(viewModel.comics)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.loveItButton.isFilled = viewModel.isLoved
        }
    }
    
    func showComicBookListError(_ errorMessage: String) {
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}
