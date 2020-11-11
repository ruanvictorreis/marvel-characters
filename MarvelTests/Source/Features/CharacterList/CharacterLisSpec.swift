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
                
                it("The user selects an item from character list") {
                    viewController.interactor.fetchCharacterList()
                    viewController.interactor.select(at: 0)
                    
                    let character = viewController.interactor.selectedCharacter
                    expect(character).toNot(beNil())
                    expect(character?.name).to(equal("Iron Man"))
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
                    viewController.interactor.setFavorite(at: 0, value: true)
                    
                    viewController.characterList = []
                    viewController.showCharacterListCalled = false
                    viewController.interactor.currentSection = .favorites
                    
                    viewController.interactor.fetchCharacterList()
                    expect(viewController.characterList).to(haveCount(1))
                    expect(viewController.showCharacterListCalled).to(beTrue())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Iron Man"))
                    
                    viewController.interactor.setFavorite(at: 0, value: false)
                    viewController.interactor.fetchCharacterList()
                    expect(viewController.characterList).to(haveCount(0))
                    expect(viewController.removeCharacterFromListCalled).to(beTrue())
                }
                
                it("The user selects an item from favorite characters list") {
                    viewController.interactor.fetchCharacterList()
                    viewController.interactor.setFavorite(at: 1, value: true)
                    
                    viewController.characterList = []
                    viewController.interactor.reset()
                    viewController.interactor.currentSection = .favorites
                    
                    viewController.interactor.fetchCharacterList()
                    viewController.interactor.select(at: 0)
                    
                    let character = viewController.interactor.selectedCharacter
                    expect(character).toNot(beNil())
                    expect(character?.name).to(equal("Captain America"))
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
                
                it("The user selects a character from the API search") {
                    viewController.interactor.searchForCharacter(searchParameter: "Captain")
                    viewController.interactor.select(at: 1)
                    
                    let character = viewController.interactor.selectedCharacter
                    expect(character).toNot(beNil())
                    expect(character?.name).to(equal("Captain Marvel"))
                }
                
                it("The user searches for a character by name from favorite list") {
                    viewController.interactor.fetchCharacterList()
                    viewController.interactor.setFavorite(at: 0, value: true)
                    viewController.interactor.setFavorite(at: 1, value: true)
                    
                    viewController.characterList = []
                    viewController.showCharacterListCalled = false
                    viewController.interactor.currentSection = .favorites
                    
                    viewController.interactor.searchForCharacter(searchParameter: "Iron")
                    expect(viewController.characterList).to(haveCount(1))
                    expect(viewController.showCharacterListCalled).to(beTrue())
                    
                    let firstCharacter = viewController.characterList.first
                    expect(firstCharacter?.name).to(equal("Iron Man"))
                }
                
                it("The user selects a character from the search in favorite list") {
                    viewController.interactor.fetchCharacterList()
                    viewController.interactor.setFavorite(at: 0, value: true)
                    viewController.interactor.setFavorite(at: 1, value: true)
                    
                    viewController.characterList = []
                    viewController.interactor.reset()
                    viewController.interactor.currentSection = .favorites
                    
                    viewController.interactor.searchForCharacter(searchParameter: "Iron")
                    viewController.interactor.select(at: 0)
                    
                    let character = viewController.interactor.selectedCharacter
                    expect(character).toNot(beNil())
                    expect(character?.name).to(equal("Iron Man"))
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
