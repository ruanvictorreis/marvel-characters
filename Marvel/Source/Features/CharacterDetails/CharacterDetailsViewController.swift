//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

protocol CharacterDetailsViewControllerProtocol: AnyObject {
    
    func showCommicBookList(comics: [ComicBook])
    
    func showComicBookListError(errorMessage: String)
}

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var characterName: UILabel!
    
    @IBOutlet private var characterDescription: UILabel!
    
    @IBOutlet private var characterThumbnail: UIImageView!
    
    @IBOutlet private var comicBookCarousel: ComicBookCarousel!
    
    // MARK: - VIP Properties
    
    var interactor: CharacterDetailsInteractorProtocol!
    
    var router: CharacterDetailsRouterProtocol!
    
    // MARK: - Public Properties
    
    var character: Character!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchComicBookList()
    }
    
    // MARK: - Private Functions
    
    private func setupNavigation() {
        self.navigationItem.title = character.name
    }
    
    private func setupUI() {
        let thumbnail = character.thumbnail
        let imageUrl = "\(thumbnail.path).\(thumbnail.extension)"
        self.characterThumbnail.load(url: imageUrl)
        self.characterName.text = character.name
        self.characterDescription.text = character.description
    }
    
    private func fetchComicBookList() {
        interactor.fetchComicBookList(character.id)
    }
}

// MARK: - CharacterDetailsViewController Protocol

extension CharacterDetailsViewController: CharacterDetailsViewControllerProtocol {

    func showCommicBookList(comics: [ComicBook]) {
        comicBookCarousel.setupUI(comics: comics)
    }
    
    func showComicBookListError(errorMessage: String) {
        hideLoading()
        showMessage(title: R.Localizable.errorTitle(), message: errorMessage)
    }
}
