//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterDetailsViewControllerProtocol: AnyObject {
    
    func showCharacterDetails(_ viewModel: CharacterDetailsViewModel)
    
    func showCommicBookList(_ comics: [ComicBook])
    
    func showComicBookListError(_ errorMessage: String)
}

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var characterName: UILabel!
    
    @IBOutlet private var characterDescription: UILabel!
    
    @IBOutlet private var characterThumbnail: UIImageView!
    
    @IBOutlet private var loveItButton: UIHeartButton!
    
    @IBOutlet private var comicBookCarousel: ComicBookCarouselView!
    
    @IBOutlet private var comicBookLoading: UIActivityIndicatorView!
    
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
    
    func showCharacterDetails(_ viewModel: CharacterDetailsViewModel) {
        characterName.text = viewModel.name
        characterDescription.text = viewModel.description
        characterThumbnail.load(url: viewModel.image)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.loveItButton.isFilled = viewModel.isLoved
        }
    }
    
    func showCommicBookList(_ comics: [ComicBook]) {
        comicBookLoading.isHidden = true
        comicBookCarousel.setupUI(comics)
    }
    
    func showComicBookListError(_ errorMessage: String) {
        comicBookLoading.isHidden = true
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}
