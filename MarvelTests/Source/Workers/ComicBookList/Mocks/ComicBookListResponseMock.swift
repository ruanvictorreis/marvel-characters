//
//  ComicBookListResponseMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

struct ComicBookListResponseMock {
    
    static func build() -> ComicBookListResponse {
        let thumbnail = Thumbnail(path: "", extension: "")
        
        let comics: [ComicBook] = [
            ComicBook(id: 1, title: "Infinity Gauntlet", thumbnail: thumbnail),
            ComicBook(id: 2, title: "X-Men: The Dark Phoenix Saga", thumbnail: thumbnail),
            ComicBook(id: 3, title: "Daredevil: Born Again", thumbnail: thumbnail),
            ComicBook(id: 4, title: "Civil War", thumbnail: thumbnail),
            ComicBook(id: 5, title: "Secret Wars", thumbnail: thumbnail)
        ]
        
        let data = ComicBooListResults(
            offset: 0,
            limit: 20,
            total: comics.count,
            count: comics.count,
            results: comics)
        
        return ComicBookListResponse(data: data)
    }
}
