//
//  ComicBookWorkerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation
@testable import Marvel

class ComicBookWorkerSucessMock: ComicBookWorkerProtocol {
    
    func fetchList(character: Int, completion: @escaping ComicBookCompletion) {
        do {
            let data = FileReader.read(self, resource: "ComicBookList")
            let response = try JSONDecoder().decode(
                ComicBookListResponse.self,
                from: data ?? Data())
            
            completion(.success(response))
        } catch {
            completion(.failure(.networkError))
        }
    }
}

class ComicBookWorkerFailureMock: ComicBookWorkerProtocol {
    
    func fetchList(character: Int, completion: @escaping ComicBookCompletion) {
        completion(.failure(.networkError))
    }
}
