//
//  CharacterLisSpec.swift
//  MarvelTests
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharacterLisSpec: QuickSpec {
    
    override func spec() {
        var viewController: CharacterListViewControllerMock!
        
        describe("List of Characters", {
            context("Given that the CharacterListScene has initialized") {
                it("All architecture components must be initialized") {
                    let interactor = CharacterListInteractor()
                    expect(interactor).notTo(beNil())
                    
                    let presenter = CharacterListPresenter()
                    expect(presenter).notTo(beNil())
                    
                    let router = CharacterListRouter()
                    expect(router).notTo(beNil())
                    
                    let builder = CharacterListBuilder()
                    expect(builder).notTo(beNil())
                }
            }
            
            context("Given that the app starts presenting a list of characters") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterListBuilderMock()
                        .build(characterListWorker: CharacterListWorkerSuccessMock())
                }
                
                it("View is presenting character list from first page") {
                    viewController.interactor.fetchCharacterList()
                    expect(viewController.characterList).to(haveCount(20))
                    expect(viewController.showCharacterListCalled).to(beTrue())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Iron Man"))
                    
                    let lastCharacter = viewController.characterList.last
                    expect(lastCharacter?.name).to(equal("Thanos"))
                }
                
                it("View is presenting character list from next page") {
                    viewController.interactor.fetchCharacterList()
                    viewController.interactor.fetchCharacterNextPage()
                    expect(viewController.characterList).to(haveCount(25))
                    expect(viewController.showCharacterListCalled).to(beTrue())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Iron Man"))
                    
                    let lastCharacter = viewController.characterList.last
                    expect(lastCharacter?.name).to(equal("Gamora"))
                }
                
                it("View can't present more characters from new pages") {
                    viewController.interactor.fetchCharacterList()
                    viewController.interactor.fetchCharacterNextPage()
                    
                    viewController.showCharacterListCalled = false
                    viewController.interactor.fetchCharacterNextPage()
                    
                    expect(viewController.characterList).to(haveCount(25))
                    expect(viewController.showCharacterListCalled).to(beFalse())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Iron Man"))
                    
                    let lastCharacter = viewController.characterList.last
                    expect(lastCharacter?.name).to(equal("Gamora"))
                }
            }
            
            context("Given that the app allows the user to choose their favorite characters") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterListBuilderMock()
                        .build(characterListWorker: CharacterListWorkerSuccessMock())
                }
                
                it("The user gets his favorite characters") {
                    viewController.interactor.fetchCharacterList()
                    
                    let characterOne = viewController.characterList[0]
                    characterOne.isFavorite = true
                    viewController.interactor.setFavorite(characterOne)
                    
                    let characterTwo = viewController.characterList[1]
                    characterTwo.isFavorite = true
                    viewController.interactor.setFavorite(characterTwo)
                    
                    viewController.characterList = []
                    viewController.showCharacterListCalled = false
                    viewController.interactor.currentSection = .favorites
                    
                    viewController.interactor.fetchCharacterList()
                    expect(viewController.characterList).to(haveCount(2))
                    expect(viewController.showCharacterListCalled).to(beTrue())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Iron Man"))
                    
                    let lastCharacter = viewController.characterList.last
                    expect(lastCharacter?.name).to(equal("Captain America"))
                }
            }
        })
    }
}
