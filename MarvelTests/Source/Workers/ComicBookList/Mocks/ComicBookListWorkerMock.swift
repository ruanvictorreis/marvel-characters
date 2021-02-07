//
//  ComicBookListWorkerMock.swift
//  MarvelTests
//
//  Created by Ruan Reis on 05/08/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

@testable import Marvel

class ComicBookListWorkerSucessMock: ComicBookWorkerProtocol {
    
    func fetchComicBookList(character: Int,
                            sucess: @escaping ComicBookWorkerSuccess,
                            failure: @escaping ComicBookWorkerError) {
        
        let response = ComicBookListResponseMock.build()
        sucess(response)
    }
}

class ComicBookListWorkerFailureMock: ComicBookWorkerProtocol {
    
    func fetchComicBookList(character: Int,
                            sucess: @escaping ComicBookWorkerSuccess,
                            failure: @escaping ComicBookWorkerError) {
        
        failure(nil)
    }
}
