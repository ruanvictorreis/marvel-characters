//
//  ComicBookListWorkerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

class ComicBookListWorkerSucessMock: ComicBookListWorkerProtocol {
    
    func fetchComicBookList(character: Int,
                            sucess: @escaping ComicBookListSuccess,
                            failure: @escaping ComicBookListError) {
        
        let response = ComicBookListResponseMock.build()
        sucess(response)
    }
}

class ComicBookListWorkerFailureMock: ComicBookListWorkerProtocol {
    
    func fetchComicBookList(character: Int,
                            sucess: @escaping ComicBookListSuccess,
                            failure: @escaping ComicBookListError) {
        
        failure(nil)
    }
}
