//
//  CharacterDetailsViewControllerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

class CharacterDetailsViewControllerMock: CharacterDetailsViewControllerProtocol {
    
    var interactor: CharacterDetailsInteractorProtocol!
    
    var comicBookList: [ComicBook] = []
    
    var errorMessage = ""
    
    var showCommicBookListCalled = false
    
    var showComicBookListErrorCalled = false
    
    func showCommicBookList(_ comics: [ComicBook]) {
        comicBookList = comics
        showCommicBookListCalled = true
    }
    
    func showComicBookListError(_ errorMessage: String) {
        self.errorMessage = errorMessage
        showComicBookListErrorCalled = true
    }
}
