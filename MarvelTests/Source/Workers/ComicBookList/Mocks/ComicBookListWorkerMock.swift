//
//  ComicBookListWorkerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation
@testable import Marvel

class ComicBookListWorkerSucessMock: ComicBookWorkerProtocol {
    
    func fetchComicBookList(character: Int, completation: @escaping ComicBookCompletation) {
        do {
            let data = FileReader.read(self, resource: "ComicBookList")
            let response = try JSONDecoder().decode(
                ComicBookListResponse.self,
                from: data ?? Data())
            
            completation(.success(response))
        } catch {
            completation(.failure(.networkError))
        }
    }
}

class ComicBookListWorkerFailureMock: ComicBookWorkerProtocol {
    
    func fetchComicBookList(character: Int, completation: @escaping ComicBookCompletation) {
        completation(.failure(.networkError))
    }
}
