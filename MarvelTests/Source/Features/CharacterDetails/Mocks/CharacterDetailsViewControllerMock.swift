//
//  CharacterDetailsViewControllerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

class CharacterDetailsViewControllerMock: CharacterDetailsViewControllerProtocol {
    
    var interactor: (CharacterDetailsInteractorProtocol &  CharacterDetailsDataStoreProtocol)!
    
    var comics: [ComicViewModel] = []
    
    var errorMessage = ""
    
    var showCharacterDetailsCalled = false
    
    var showComicBookListErrorCalled = false
    
    func startComicsLoading() {}
    
    func stopComicsLoading() {}
    
    func showCharacterDetails(_ viewModel: CharacterDetailsViewModel) {
        self.comics = viewModel.comics
        showCharacterDetailsCalled = true
    }
    
    func showCharacterDetailsError(_ errorMessage: String) {
        self.errorMessage = errorMessage
        showComicBookListErrorCalled = true
    }
}
