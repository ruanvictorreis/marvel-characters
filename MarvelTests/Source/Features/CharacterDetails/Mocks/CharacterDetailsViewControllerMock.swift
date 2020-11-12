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
    
    var comicBookList: [ComicBook] = []
    
    var errorMessage = ""
    
    var showCharacterDetailsCalled = false
    
    var showCommicBookListCalled = false
    
    var showComicBookListErrorCalled = false
    
    func showCharacterDetails(_ viewModel: CharacterDetailsViewModel) {
        showCharacterDetailsCalled = true
    }
    
    func showCommicBookList(_ comics: [ComicBook]) {
        comicBookList = comics
        showCommicBookListCalled = true
    }
    
    func showComicBookListError(_ errorMessage: String) {
        self.errorMessage = errorMessage
        showComicBookListErrorCalled = true
    }
}
