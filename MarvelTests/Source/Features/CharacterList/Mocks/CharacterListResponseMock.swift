//
//  CharacterListResponseMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

struct CharacterListResponseMock {
    
    static func build(offset: Int, pageCount: Int) -> CharacterListResponse {
        let thumbnail = Thumbnail(path: "", extension: "")
        
        let characters: [Character] = [
            Character(id: 1, name: "Iron Man", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 2, name: "Captain America", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 3, name: "Thor", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 4, name: "Spider Man", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 5, name: "Black Widon", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 6, name: "Marvel Captain", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 7, name: "Doctor Strange", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 8, name: "Gambit", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 9, name: "Xavier", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 10, name: "Iron Fist", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 11, name: "Jessica Jones", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 12, name: "Daredevil", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 13, name: "Deadpool", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 14, name: "Wolverine", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 15, name: "Ant Man", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 16, name: "Loki", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 17, name: "Ultron", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 18, name: "Adam", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 19, name: "Galactus", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 20, name: "Thanos", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 21, name: "Drax", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 22, name: "Rocket", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 23, name: "Hulk", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 24, name: "Groot", description: "",
                      isFavorite: false, thumbnail: thumbnail),
            Character(id: 25, name: "Gamora", description: "",
                      isFavorite: false, thumbnail: thumbnail)]
        
        let total = characters.count
        let limit = offset + pageCount
        let endPage = limit < total ? limit : total
        let charactersOffset = Array(characters[offset..<endPage])
        
        let data = CharacterListResults(
            offset: offset,
            limit: limit,
            total: total,
            count: charactersOffset.count,
            results: charactersOffset)
        
        return CharacterListResponse(data: data)
    }
}
