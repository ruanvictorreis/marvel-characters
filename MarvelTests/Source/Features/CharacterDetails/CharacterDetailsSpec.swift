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
                    expect(viewController.comics).to(haveCount(20))
                    expect(viewController.showCharacterDetailsCalled).to(beTrue())
                    
                    let firstComic = viewController.comics.first
                    expect(firstComic?.title).to(equal("Wolverine Saga (2009) #7"))
                    
                    let lastComic = viewController.comics.last
                    expect(lastComic?.title).to(equal("True Believers: Iron Man 2020 - War Machine (2020) #1"))
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
                    expect(viewController.comics).to(haveCount(0))
                }
            }
        }
    }
}
