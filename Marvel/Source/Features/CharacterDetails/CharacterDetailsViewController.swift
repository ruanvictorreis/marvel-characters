//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterDetailsViewControllerProtocol: AnyObject {
    
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
    
    // MARK: - Public Properties
    
    var character: Character!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchComicBookList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loveItButton.isFilled = character.isFavorite
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupNavigation(isHidden: true)
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        characterName.text = character.name
        characterDescription.text = character.description
        comicBookCarousel.setupUI()
        
        let thumbnail = character.thumbnail
        let imageUrl = "\(thumbnail.path).\(thumbnail.extension)"
        characterThumbnail.load(url: imageUrl)
    }
    
    private func fetchComicBookList() {
        interactor.fetchComicBookList(character.id)
    }
    
    @IBAction private func loveIt(_ sender: UIHeartButton) {
        loveItButton.toggleIt()
        character.isFavorite = loveItButton.isFilled
        interactor.setFavorite(character)
    }
    
    @IBAction private func close(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    } 
}

// MARK: - CharacterDetailsViewControllerProtocol Extension

extension CharacterDetailsViewController: CharacterDetailsViewControllerProtocol {

    func showCommicBookList(_ comics: [ComicBook]) {
        comicBookLoading.isHidden = true
        comicBookCarousel.setupUI(comics)
    }
    
    func showComicBookListError(_ errorMessage: String) {
        comicBookLoading.isHidden = true
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}
