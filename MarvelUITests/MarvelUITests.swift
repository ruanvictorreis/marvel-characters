//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Ruan Reis on 04/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import KIF
import XCTest
import BetterSegmentedControl

@testable import Marvel


class MarvelUITests: KIFTestCase {
    
    func testFavoriteCharacters() {
        let characters = ["Iron Man", "Captain America", "Thor"]
        characters.forEach({ character in
            searchForCharacter(withName: character)
            selectFirstCharacter(withName: character)
            loveCharacter(initalStatus: false)
            backToCharacterList()
        })

        cancelSearch()
        selectSegmentControl(at: 1)
        
        characters.forEach({ character in
            searchForCharacter(withName: character, waiting: false)
            selectFirstCharacter(withName: character)
            loveCharacter(initalStatus: true)
            backToCharacterList()
            waitForNoCharactersFoundMessage()
        })
        
        cancelSearch()
        selectSegmentControl(at: 0)
    }
    
    func testSearchForCharacters() {
        let characters = ["Thanos", "Ultron", "Galactus"]
        characters.forEach({ character in
            searchForCharacter(withName: character)
            selectFirstCharacter(withName: character)
            backToCharacterList()
        })
        
        cancelSearch()
    }
    
    func testSearchWithoutResults() {
        let characters = ["Batman", "Flash", "Wonder Woman"]
        characters.forEach({ character in
            searchForCharacter(withName: character, waiting: false)
            waitForNoCharactersFoundMessage()
        })
    }
}

extension MarvelUITests {
    
    func waitForLoadingFinish() {
        let indexPath = UIElements.firstIndexPath
        let collectionId = UIElements.collection
        tester().waitForAnimationsToFinish()
        tester().waitForCell(at: indexPath, inCollectionViewWithAccessibilityIdentifier: collectionId)
    }
    
    func waitForNoCharactersFoundMessage() {
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: UIElements.noCharacters)
    }
    
    func searchForCharacter(withName character: String, waiting: Bool = true) {
        if waiting { waitForLoadingFinish() }
        tester().tapView(withAccessibilityLabel: UIElements.search)
        tester().clearTextFromFirstResponder()
        tester().enterText(intoCurrentFirstResponder: character)
    }
    
    func selectFirstCharacter(withName character: String) {
        let indexPath = UIElements.firstIndexPath
        let collectionId = UIElements.collection
        waitForLoadingFinish()
        tester().tapItem(at: indexPath, inCollectionViewWithAccessibilityIdentifier: collectionId)
        tester().waitForView(withAccessibilityLabel: character)
    }
    
    func selectSegmentControl(at index: Int) {
        tester().waitForAnimationsToFinish()
        
        let identifier = UIElements.segmentedControl
        let segmentedControll = tester().waitForView(
            withAccessibilityLabel: identifier) as! BetterSegmentedControl
        
        segmentedControll.setIndex(index)
    }
    
    func loveCharacter(initalStatus: Bool) {
        guard let heartButton = tester().waitForView(withAccessibilityLabel: UIElements.heart)
            as? UIHeartButton else { return }
        
        if heartButton.isFilled == initalStatus {
            tester().tapView(withAccessibilityLabel: UIElements.heart)
        }
    }
    
    func backToCharacterList() {
        tester().tapView(withAccessibilityLabel: UIElements.back)
    }
    
    func cancelSearch() {
        tester().tapView(withAccessibilityLabel: UIElements.cancel)
    }
}
