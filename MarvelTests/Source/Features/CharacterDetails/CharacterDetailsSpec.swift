//
//  CharacterDetailsSpec.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharacterDetailsSpec: QuickSpec {
    
    override func spec() {
        var viewController: CharacterDetailsViewControllerMock!
        
        describe("Characters Details") {
            context("Given that the user selected a characters") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterDetailsBuilderMock()
                        .build(characterListWorker: CharacterListWorkerSuccessMock(),
                               comickBookListWorker: ComicBookListWorkerSucessMock())
                }
                
                it("View is presenting the comics that the characters participated") {
                    viewController.interactor.fetchComicBookList(0)
                    expect(viewController.comicBookList).to(haveCount(5))
                    expect(viewController.showCommicBookListCalled).to(beTrue())
                    
                    let firstComic = viewController.comicBookList.first
                    expect(firstComic?.title).to(equal("Infinity Gauntlet"))
                    
                    let lastComic = viewController.comicBookList.last
                    expect(lastComic?.title).to(equal("Secret Wars"))
                }
            }
            
            context("Given that the user can choose a character as favorite on details scene") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterDetailsBuilderMock()
                        .build(characterListWorker: CharacterListWorkerSuccessMock(),
                               comickBookListWorker: ComicBookListWorkerSucessMock())
                }
                
                it("It is possible to save and delete a character as favorite") {
                    let character = Character(
                        id: 1, name: "Thanos",
                        description: "",
                        isFavorite: false,
                        thumbnail: Thumbnail(path: "", extension: ""))
                    
                    character.isFavorite = true
                    viewController.interactor.setFavorite(character)
                    
                    character.isFavorite = false
                    viewController.interactor.setFavorite(character)
                }
            }
            
            context("Given that an error ocurred while fetching the comics") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterDetailsBuilderMock()
                        .build(characterListWorker: CharacterListWorkerFailureMock(),
                               comickBookListWorker: ComicBookListWorkerFailureMock())
                }
                
                it("View is presenting the comics that the characters participated") {
                    viewController.interactor.fetchComicBookList(0)
                    expect(viewController.comicBookList).to(haveCount(0))
                    expect(viewController.showCommicBookListCalled).to(beFalse())
                }
            }
        }
    }
}
