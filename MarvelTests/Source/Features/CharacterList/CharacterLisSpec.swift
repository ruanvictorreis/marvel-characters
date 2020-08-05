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
        
        describe("List of Characters") {
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
                
                it("The user gets his favorite characters and can also delete them") {
                    viewController.interactor.fetchCharacterList()
                    
                    let characterOne = viewController.characterList[0]
                    characterOne.isFavorite = true
                    viewController.interactor.setFavorite(characterOne)
                    
                    viewController.characterList = []
                    viewController.showCharacterListCalled = false
                    viewController.interactor.currentSection = .favorites
                    
                    viewController.interactor.fetchCharacterList()
                    expect(viewController.characterList).to(haveCount(1))
                    expect(viewController.showCharacterListCalled).to(beTrue())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Iron Man"))
                    
                    characterOne.isFavorite = false
                    viewController.interactor.setFavorite(characterOne)
                    viewController.interactor.fetchCharacterList()
                    expect(viewController.characterList).to(haveCount(0))
                    expect(viewController.removeCharacterFromListCalled).to(beTrue())
                }
            }
            
            context("Given that the app allows the user to search for characters") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterListBuilderMock()
                        .build(characterListWorker: CharacterListWorkerSuccessMock())
                }
                
                it("The user searches for a character by name from API") {
                    viewController.interactor.searchForCharacter(searchParameter: "Captain")
                    expect(viewController.characterList).to(haveCount(2))
                    expect(viewController.showCharacterListCalled).to(beTrue())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Captain America"))
                    
                    let lastCharacter = viewController.characterList.last
                    expect(lastCharacter?.name).to(equal("Captain Marvel"))
                }
                
                it("The user searches for a character by name from favorite list") {
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
                    
                    viewController.interactor.searchForCharacter(searchParameter: "Iron")
                    expect(viewController.characterList).to(haveCount(1))
                    expect(viewController.showCharacterListCalled).to(beTrue())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Iron Man"))
                }
            }
            
            context("Given that the app is unable to connect to the API") {
                afterEach {
                    viewController = nil
                }
                
                beforeEach {
                    viewController = CharacterListBuilderMock()
                        .build(characterListWorker: CharacterListWorkerFailureMock())
                }
                
                it("View is presenting error alert when fetching characters") {
                    viewController.interactor.fetchCharacterList()
                    expect(viewController.characterList).to(haveCount(0))
                    expect(viewController.showCharacterListCalled).to(beFalse())
                    expect(viewController.showCharacterListErrorCalled).to(beTrue())
                    expect(viewController.errorMessage).to(equal(R.Localizable.errorDescription()))
                }
                
                it("View is presenting error alert when fetching characters next page") {
                    viewController.interactor.fetchCharacterList()
                    viewController.interactor.fetchCharacterNextPage()
                    expect(viewController.characterList).to(haveCount(0))
                    expect(viewController.showCharacterListCalled).to(beFalse())
                    expect(viewController.showCharacterListErrorCalled).to(beTrue())
                    expect(viewController.errorMessage).to(equal(R.Localizable.errorDescription()))
                }
                
                it("View is presenting error alert when searching characters") {
                    viewController.interactor.searchForCharacter(searchParameter: "Captain")
                    expect(viewController.characterList).to(haveCount(0))
                    expect(viewController.showCharacterListCalled).to(beFalse())
                    expect(viewController.showCharacterListErrorCalled).to(beTrue())
                    expect(viewController.errorMessage).to(equal(R.Localizable.errorDescription()))
                }
            }
        }
    }
}
