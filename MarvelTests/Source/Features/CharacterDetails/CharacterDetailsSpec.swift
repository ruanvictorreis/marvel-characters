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
        
        let character = Character(
            id: 1, name: "Thanos",
            description: "The Inevitable",
            isFavorite: false,
            thumbnail: Thumbnail(path: "", extension: ""))
        
        describe("Characters Details") {
            context("Given that the user selected a characters") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterDetailsBuilderMock().build(
                        character: character,
                        characterListWorker: CharacterListWorkerSuccessMock(),
                        comickBookListWorker: ComicBookListWorkerSucessMock())
                }
                
                it("View is presenting the comics that the characters participated") {
                    viewController.interactor.fetchCharacterDetails()
                    expect(viewController.comicBookList).to(haveCount(5))
                    expect(viewController.showCharacterDetailsCalled).to(beTrue())
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
                    viewController = CharacterDetailsBuilderMock().build(
                        character: character,
                        characterListWorker: CharacterListWorkerSuccessMock(),
                        comickBookListWorker: ComicBookListWorkerSucessMock())
                }
                
                it("It is possible to save and delete a character as favorite") {
                    viewController.interactor.setFavorite(true)
                    viewController.interactor.setFavorite(false)
                }
            }
            
            context("Given that an error ocurred while fetching the comics") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterDetailsBuilderMock().build(
                        character: character,
                        characterListWorker: CharacterListWorkerFailureMock(),
                        comickBookListWorker: ComicBookListWorkerFailureMock())
                }
                
                it("View is presenting the comics that the characters participated") {
                    viewController.interactor.fetchCharacterDetails()
                    expect(viewController.comicBookList).to(haveCount(0))
                    expect(viewController.showCommicBookListCalled).to(beFalse())
                }
            }
        }
    }
}
